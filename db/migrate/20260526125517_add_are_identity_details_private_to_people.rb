class AddAreIdentityDetailsPrivateToPeople < ActiveRecord::Migration[8.1]
  def change
    add_column :people, :are_identity_details_private, :string
  end
end
