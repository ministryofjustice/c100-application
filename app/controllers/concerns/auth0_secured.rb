module Auth0Secured
  extend ActiveSupport::Concern

  included do
    before_action :logged_in_using_omniauth?
  end

  private

  # :nocov:
  def logged_in_using_omniauth?
    redirect_to backoffice_path, allow_other_host: true unless helpers.admin_signed_in?
  end
  # :nocov:
end
