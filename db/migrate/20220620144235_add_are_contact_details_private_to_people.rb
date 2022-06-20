class AddAreContactDetailsPrivateToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :are_contact_details_private, :string
  end
end
