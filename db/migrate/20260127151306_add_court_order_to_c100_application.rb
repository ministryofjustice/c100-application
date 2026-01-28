class AddCourtOrderToC100Application < ActiveRecord::Migration[8.1]
  def change
    add_column :c100_applications, :existing_court_order, :string
    add_column :c100_applications, :court_order_case_number, :string
    add_column :c100_applications, :court_order_expiry_date, :date
  end
end
