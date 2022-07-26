class AddPrivacyOptionsToPeople < ActiveRecord::Migration[6.0]
  def up
    add_column :people, :contact_details_private, :string, array: true, default: []
  end
 
  def down
    remove_column :people, :contact_details_private
  end

end
