class AddHasCourtOrderUploadsToC100Applications < ActiveRecord::Migration[7.0]
  def change
    add_column :c100_applications, :has_court_order_uploads, :string
  end
end
