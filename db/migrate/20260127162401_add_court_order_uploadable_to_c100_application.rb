class AddCourtOrderUploadableToC100Application < ActiveRecord::Migration[8.1]
  def change
    add_column :c100_applications, :existing_court_order_uploadable, :string
  end
end
