class AddCsvGeneratedToPaymentReportLog < ActiveRecord::Migration[7.0]
  def change
    add_column :payment_report_logs, :csv_generated, :boolean
  end
end
