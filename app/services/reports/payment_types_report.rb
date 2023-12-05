# frozen_string_literal: true

module Reports
  # :nocov:
  class PaymentTypesReport
    require 'csv'

    class << self
      def run
        return unless ENV.key?('PAYMENT_TYPE_REPORT_EMAIL')

        Rails.logger.info "Sending payment types report"
        @log = PaymentReportLog.create

        begin
          retries ||= 0
          Rails.logger.info "try ##{retries}"
          @log.update(mailer_retries: retries)
          report_csv
          @log.update(csv_generated: true)
          ReportsMailer.payment_types_report(
            report_csv,
            to_address: ENV['PAYMENT_TYPE_REPORT_EMAIL'],
            cc_address: ENV['PAYMENT_TYPE_REPORT_EMAIL_CC'],
          ).deliver_later
        rescue PG::ConnectionBad => e
          retry if (retries += 1) < 3
          @log.update(mailer_error: "#{e.class.name}: #{e.message}")
          Sentry.capture_exception(e)
          raise # Reraises PG::ConnectionBad if still failing
        end
      end

      def report_data
        C100Application
          .completed
          .where(completed_at: 1.day.ago...Time.now)
          .group(:payment_type)
          .count
      end

      def report_csv
        @_report_csv ||= CSV.generate do |csv|
          csv << ['Date', Date.today]
          csv << %w[PaymentType Count]
          report_data.each { |row| csv << row }
        end
      end
    end
  end
end
