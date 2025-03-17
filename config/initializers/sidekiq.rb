# The queue adapter is set in `config/application.rb`
# Refer to that file for more details.
#
Sidekiq.configure_server do |config|
  config.death_handlers << lambda { |job, ex|
    Sentry.capture_exception(ex, level: 'error', tags: { job_class: job['class'], job_id: job['jid'] })
  }

  Rails.logger = Sidekiq.logger

  if Rails.env.inquiry.production?
    Sidekiq.logger.formatter = Sidekiq::Logger::Formatters::JSON.new

    # Level is `INFO`. If it is too noisy for prod, uncomment this line:
    # config.logger.level = Logger::WARN
  end
end
