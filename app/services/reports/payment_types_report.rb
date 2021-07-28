# frozen_string_literal: true

module Reports
  # :nocov:
  class PaymentTypesReport
    require 'csv'

    class << self
      def run
        return unless ENV.key?('PAYMENT_TYPE_REPORT_EMAIL')

        report_csv = CSV.generate do |csv|
          csv << ['Date', Date.today]
          csv << %(PaymentType Count)
          report_data.each { |row| csv << row }
        end

        Rails.logger.info "Sending payment types report"

        ReportsMailer.payment_types_report(
          report_csv,
          to_address: ENV['PAYMENT_TYPE_REPORT_EMAIL'],
          cc_address: ENV['PAYMENT_TYPE_REPORT_EMAIL_CC'],
        ).deliver_later
      end

      def report_data
        C100Application
          .completed
          .where(completed_at: 1.day.ago...Time.now)
          .group(:payment_type)
          .count
      end
    end
  end
end
