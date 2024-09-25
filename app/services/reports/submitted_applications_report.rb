# frozen_string_literal: true

module Reports
  # :nocov:
  class SubmittedApplicationsReport
    require 'csv'

    class << self
      def run
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
        to = DateTime.today
        C100Application
          .completed
          .where(completed_at: from...to)
          .count
      end

      def report_csv
        CSV.generate do |csv|
          csv << ['Date', Date.today]
          csv << ['Reference Number', 'Date/Time Submitted']
          report_data.each { |row| csv << row }
          csv << ['Total Applications', report_data.count]
        end
      end

      ReportsMailer.submitted_applications_report(
        report_csv,
        to_address: ENV['PAYMENT_TYPE_REPORT_EMAIL'],
      ).deliver_now
    end
  end
end
