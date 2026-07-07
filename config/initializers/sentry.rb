## DEV SENTRY DSN
EXCLUDE_PATHS = ['/ping', '/ping.json', '/health', '/health.json'].freeze
Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN']
  # config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Add data like request headers and IP for users,
  # see https://docs.sentry.io/platforms/ruby/data-management/data-collected/ for more info
  config.profiles_sample_rate = 1.0
  config.traces_sample_rate = 1.0
  config.profiler_class = Sentry::Vernier::Profiler

  config.traces_sampler = lambda do |sampling_context|
    transaction_context = sampling_context[:transaction_context]
    transaction_name = transaction_context[:name]

    transaction_name.in?(EXCLUDE_PATHS) ? 0.0 : 0.01
  end
end
