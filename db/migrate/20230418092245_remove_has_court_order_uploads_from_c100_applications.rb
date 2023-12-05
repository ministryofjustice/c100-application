class RemoveHasCourtOrderUploadsFromC100Applications < ActiveRecord::Migration[7.0]
  def change
    remove_column :c100_applications, :has_court_order_uploads, :string
  end
end
