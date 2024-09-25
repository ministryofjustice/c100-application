# frozen_string_literal: true

module Reports
  # :nocov:
  class SubmittedApplicationsReport
    require 'csv'

    class << self
      def run
        return unless ENV.key?('PAYMENT_TYPE_REPORT_EMAIL')

        Rails.logger.info "Sending submitted applications report"

        begin
          retries ||= 0
          Rails.logger.info "try ##{retries}"
          report_csv
          ReportsMailer.submitted_applications_report(
            report_csv,
            to_address: ENV['PAYMENT_TYPE_REPORT_EMAIL'],
          ).deliver_later
        rescue PG::ConnectionBad => e
          retry if (retries += 1) < 3
          Sentry.capture_exception(e)
          raise
        end
      end

      def report_data
        from = 1.day.ago.beginning_of_day + 6.hours
        to = Date.today
        CompletedApplicationsAudit
          .where(completed_at: from...to)
          .pluck(:reference_code, :completed_at)
      end

      def report_csv
        CSV.generate do |csv|
          csv << ['Date', Date.today]
          csv << ['Reference Number', 'Date/Time Submitted']
          report_data.each { |row| csv << row }
          csv << ['Total Applications', report_data.count]
        end
      end
    end
  end
end
