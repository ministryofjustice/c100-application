task payments_timeout: [:stdout_environment] do
  Rails.logger.info "Starting payments timeout for incomplete payments older than 60 mins"

  PaymentsTimeoutJob.run

  Rails.logger.info "Finished payments timeout"
end
