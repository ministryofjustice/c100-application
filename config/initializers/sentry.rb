# Will use SENTRY_DSN environment variable if set
#
Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN']

  config.async = ->(event) { SentryJob.perform_later(event) }

  # Convert to regex, otherwise Sentry will threat them as words
  # https://github.com/getsentry/raven-ruby/blob/master/lib/raven/processor/sanitizedata.rb
  # config.sanitize_fields = Rails.application.config.filter_parameters.map { |w| "#{w}+" }
end

