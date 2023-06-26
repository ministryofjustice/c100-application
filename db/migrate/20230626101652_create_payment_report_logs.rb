class CreatePaymentReportLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_report_logs, id: :uuid do |t|
      t.integer :mailer_retries, default: 0, null: false
      t.string :mailer_error
      t.boolean :mailer_started
      t.boolean :mailer_personalised

      t.timestamps
    end
  end
end
