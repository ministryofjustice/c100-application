class ApplicationController < ActionController::Base
  include SecurityHandling
  include SessionHandling
  include ErrorHandling

  before_action :show_maintenance_page

  # This is required to get request attributes in to the production logs.
  # See the various lograge configurations in `production.rb`.
  def append_info_to_payload(payload)
    super
    payload[:referrer] = request&.referrer
    payload[:session_id] = request&.session&.id
    payload[:user_agent] = request&.user_agent
    payload[:ip] = request&.remote_ip
  end

  def current_c100_application
    return nil if session[:c100_application_id].blank?
    @_current_c100_application ||= C100Application.includes(
      :people, :relationships, :abuse_concerns, :minors,
      children: :child_residence
    ).find_by_id(session[:c100_application_id])
  end
  helper_method :current_c100_application

  def check_c100_application_status
    raise Errors::CaseSubmitted if current_c100_application.completed?
  end

  def store_step_path_in_session
    session[:current_step_path] = request.fullpath
  end

  def current_step_path
    session[:current_step_path]
  end

  private

  def reset_c100_application_session
    session.delete(:c100_application_id)
    session.delete(:last_seen)

    # ensure we don't have a memoized record anymore
    @_current_c100_application = nil
  end

  def initialize_c100_application(attributes = {})
    return C100Application.new if attributes.blank?

    C100Application.create(attributes).tap do |c100_application|
      session[:c100_application_id] = c100_application.id
    end
  end

  # :nocov:
  def show_maintenance_page(config = Rails.application.config)
    if config.maintenance_enabled
      Rails.logger.info("Remote IP: #{request.remote_ip}")
    end
    return if !config.maintenance_enabled || config.maintenance_allowed_ips.include?(request.remote_ip)

    render 'static_pages/maintenance', status: :service_unavailable
  end
  # :nocov:
end
