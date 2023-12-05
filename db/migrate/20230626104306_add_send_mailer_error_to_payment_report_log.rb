class AddSendMailerErrorToPaymentReportLog < ActiveRecord::Migration[7.0]
  def change
    add_column :payment_report_logs, :send_mailer_error, :string
  end
end
