EXCLUDE_PATHS = ['/ping', '/ping.json', '/health', '/health.json'].freeze

# Will use SENTRY_DSN environment variable if set
Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  config.traces_sample_rate = 1.0
  config.profiles_sample_rate = 1.0

  config.async = ->(event) { SentryJob.perform_later(event) }

  # Convert to regex, otherwise Sentry will threat them as words
  # https://github.com/getsentry/raven-ruby/blob/master/lib/raven/processor/sanitizedata.rb
  # config.sanitize_fields = Rails.application.config.filter_parameters.map { |w| "#{w}+" }

  config.traces_sampler = lambda do |sampling_context|
    transaction_context = sampling_context[:transaction_context]
    transaction_name = transaction_context[:name]

    transaction_name.in?(EXCLUDE_PATHS) ? 0.0 : 0.01
  end

  # config.before_send = lambda do |event, hint|
  #   # NOTE: hint[:exception] would be a String if you use async callback
  #   if hint[:exception].is_a?(Puma::HttpParserError)
  #     nil
  #   else
  #     event
  #   end
  # end
end
