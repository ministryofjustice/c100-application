Rails.application.config.before_configuration do
  Raven.configuration.silence_ready = true
end

class Pa11yciHeader
  DEFAULT_NAME = 'PA11YCI'.freeze

  def initialize(app, opts = {}, &blk)
    @app = app
    @blk = blk
    @header_name = ['HTTP_', (opts[:header_name] || DEFAULT_NAME)].join
  end

  attr_reader :app, :header_name, :blk

  def call(env)
    req = ActionDispatch::Request.new(env)
    blk.call(req, req.get_header(header_name)) if req.has_header?(header_name)
    app.call(req.env)
  end
end

Rails.application.configure do
  config.cache_classes = true

  config.eager_load = false

  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => 'public, max-age=3600'
  }

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_dispatch.show_exceptions = false

  config.action_controller.allow_forgery_protection = false
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :test

  config.active_job.queue_adapter = :test

  config.active_support.deprecation = :stderr

  # So we can always expect the same value in tests
  routes.default_url_options = { host: 'https://c100.justice.uk' }
  config.action_mailer.default_url_options = { host: 'https://c100.justice.uk' }

  # NB: Because of the way the form builder works, and hence the
  # gov.uk elements formbuilder, exceptions will not be raised for
  # missing translations of model attribute names. The form will
  # get the constantized attribute name itself, in form labels.
  config.action_view.raise_on_missing_translations = true

  config.x.analytics_tracking_id = 'faketrackingid'

  config.middleware.use(Pa11yciHeader) do |request, postcode|
    request.session[:c100_application_id] = C100Application.create(
      children_postcode: postcode,
      status: 1,
    ).id
  end
end
