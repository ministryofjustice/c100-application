module SecurityHandling
  extend ActiveSupport::Concern

  included do
    # :nocov:
    if ENV.fetch('HTTP_AUTH_ENABLED', false)
      http_basic_authenticate_with name: ENV.fetch('HTTP_AUTH_USER'), password: ENV.fetch('HTTP_AUTH_PASSWORD')
    end
    # :nocov:

    protect_from_forgery with: :exception, prepend: true

    before_action :drop_dangerous_headers!,
                  :ensure_session_validity

    after_action :set_security_headers

    helper_method :session_expire_in_minutes
  end

  def session_expire_in_minutes
    Rails.configuration.x.session.expires_in_minutes
  end

  def session_expire_in_seconds
    session_expire_in_minutes * 60
  end

  private

  def ensure_session_validity
    epoch = Time.now.to_i

    if epoch - session.fetch(:last_seen, epoch) > session_expire_in_seconds
      sentry_debug_session_expire(epoch) # Temporary for debug purposes
      reset_session
    end

    session[:last_seen] = epoch
  end

  def drop_dangerous_headers!
    request.env.except!('HTTP_X_FORWARDED_HOST') # just drop the variable
  end

  def set_security_headers
    additional_headers_for_all_requests.each do |name, value|
      response.set_header(name, value)
    end
  end

  def additional_headers_for_all_requests
    {
      'X-Frame-Options'           => 'SAMEORIGIN',
      'X-XSS-Protection'          => '1; mode=block',
      'X-Content-Type-Options'    => 'nosniff',
      'Strict-Transport-Security' => 'max-age=15768000; includeSubDomains',
    }
  end

  # :nocov:
  def sentry_debug_session_expire(epoch)
    return if Rails.application.config.consider_all_requests_local

    exception = StandardError.new('ensure_session_validity')

    Raven.extra_context(
      epoch_time: epoch,
      session_last_seen: session[:last_seen],
      session_expire_in_seconds: session_expire_in_seconds,
      session_id: session[:session_id],
      c100_application_id: session[:c100_application_id],
    )

    Raven.capture_exception(exception)
  end
  # :nocov:
end
