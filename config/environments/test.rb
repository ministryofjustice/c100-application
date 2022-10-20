<<<<<<< HEAD
=======
require "active_support/core_ext/integer/time"

# The test environment is used exclusively to run your application's
# test suite. You never need to work with it otherwise. Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs. Don't rely on the data there!

>>>>>>> merge-new-c100
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
  # Settings specified here will take precedence over those in config/application.rb.

<<<<<<< HEAD
  config.cache_classes = true
  config.action_view.cache_template_loading = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false
=======
  # Turn false under Spring and add config.action_view.cache_template_loading = true.
  config.cache_classes = true
  config.action_view.cache_template_loading = true

  # Eager loading loads your whole application. When running a single test locally,
  # this probably isn't necessary. It's a good idea to do in a continuous integration
  # system, or in some way before deploying your code.
  config.eager_load = ENV["CI"].present?
>>>>>>> merge-new-c100

  # Configure public file server for tests with Cache-Control for performance.
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{1.hour.to_i}"
  }

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  config.action_mailer.perform_caching = false
<<<<<<< HEAD
=======

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
>>>>>>> merge-new-c100
  config.action_mailer.delivery_method = :test

  config.active_job.queue_adapter = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

<<<<<<< HEAD
=======
  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raises error for missing translations.
  config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

>>>>>>> merge-new-c100
  # So we can always expect the same value in tests
  routes.default_url_options = { host: 'https://c100.justice.uk' }
  config.action_mailer.default_url_options = { host: 'https://c100.justice.uk' }

<<<<<<< HEAD
  # Raises error for missing translations.
  config.action_view.raise_on_missing_translations = true
=======
>>>>>>> merge-new-c100
  config.x.analytics_tracking_id = 'faketrackingid'

  config.middleware.use(Pa11yciHeader) do |request, postcode|
    request.session[:c100_application_id] = C100Application.create(
      children_postcode: postcode,
      status: 1,
    ).id
  end
<<<<<<< HEAD
=======
  # Needed as tests are run using rake commands and we use dotenv-rails
  config.web_console.development_only = false
>>>>>>> merge-new-c100
end
