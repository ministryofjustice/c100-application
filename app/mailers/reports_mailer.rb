class ReportsMailer < NotifyMailer
  #
  # Internal reports to be sent by email. Triggered by `daily_tasks`.
  #
  def failed_emails_report(report_content, to_address:)
    set_template(:failed_emails_report)
    set_personalisation(report_content:)

    mail to: to_address
  end

  def submitted_applications_report(report_csv, to_address:)
    log 'Starting submitted_applications_report'
    set_template(:submitted_applications_report)
    log 'Setting personalisation'
    set_personalisation(
      report_date: Date.parse(Date.today.to_s).strftime("%d/%m/%y"),
      link_to_report: Notifications.prepare_upload(
        StringIO.new(report_csv),
      )
    )
    log 'Sending mail'
    mail(to: to_address)
  rescue StandardError => e
    log "#{e.class.name}: #{e.message}"
    raise
  end

  def payment_types_report(report_csv, to_address:, cc_address:)
    @log = PaymentReportLog.where('created_at > ?', 6.hours.ago).first
    log 'Starting payment_types_report'
    set_template(:payment_types_report)
    log 'Setting personalisation'
    @log.try(:update, mailer_started: true)
    set_personalisation(
      link_to_report: Notifications.prepare_upload(
        StringIO.new(report_csv),
      )
    )
    @log.try(:update, mailer_personalised: true)
    log 'Sending mail'
    mail(to: to_address, cc: cc_address)
  rescue StandardError => e
    log "#{e.class.name}: #{e.message}"
    @log.try(:update, send_mailer_error: "#{e.class.name}: #{e.message}")
    raise
  end

  private

  def log(message)
    Rails.logger.info message
  end
end
