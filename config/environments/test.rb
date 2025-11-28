require "active_support/core_ext/integer/time"

# The test environment is used exclusively to run your application's
# test suite. You never need to work with it otherwise. Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs. Don't rely on the data there!

class Pa11yciHeader
  DEFAULT_NAME = 'PA11YCI'.freeze

  def initialize(app, opts = {}, &blk)
    @app = app
    @blk = blk
    @header_name = ['HTTP_', opts[:header_name] || DEFAULT_NAME].join
  end

  attr_reader :app, :header_name, :blk

  def call(env)
    req = ActionDispatch::Request.new(env)
    blk.call(req, req.get_header(header_name)) if req.has_header?(header_name)
    app.call(req.env)
  end
end

# rubocop:disable Metrics/BlockLength
Rails.application.configure do
  # Configure 'rails notes' to inspect Cucumber files
  config.annotations.register_directories('features')
  config.annotations.register_extensions('feature') { |tag| /#\s*(#{tag}):?\s*(.*)$/ }

  # Settings specified here will take precedence over those in config/application.rb.

  # Turn false under Spring and add config.action_view.cache_template_loading = true.
  config.cache_classes = false
  config.action_view.cache_template_loading = true

  # While tests run files are not watched, reloading is not necessary.
  config.enable_reloading = false

  # Eager loading loads your entire application. When running a single test locally,
  # this is usually not necessary, and can slow down your test suite. However, it's
  # recommended that you enable it in continuous integration systems to ensure eager
  # loading is working properly before deploying your code.
  config.eager_load = ENV["CI"].present?

  # Configure public file server for tests with cache-control for performance.
  config.public_file_server.headers = { "cache-control" => "public, max-age=3600" }

  # Show full error reports.
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  config.active_job.queue_adapter = :test

  # Set host to be used by links generated in mailer templates.
  config.action_mailer.default_url_options = { host: "example.com" }

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations.
  config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # So we can always expect the same value in tests
  routes.default_url_options = { host: 'https://c100.justice.uk' }
  config.action_mailer.default_url_options = { host: 'https://c100.justice.uk' }

  config.x.analytics_tracking_id = 'faketrackingid'

  config.middleware.use(Pa11yciHeader) do |request, postcode|
    request.session[:c100_application_id] = C100Application.create(
      children_postcode: postcode,
      status: 1,
    ).id
  end

  # Needed as tests are run using rake commands and we use dotenv-rails
  config.web_console.development_only = false

  # Raise error when a before_action's only/except options reference missing actions.
  # config.action_controller.raise_on_missing_callback_actions = true
end
# rubocop:enable Metrics/BlockLength
