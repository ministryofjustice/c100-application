class RemoveOldPhoneColumns < ActiveRecord::Migration[7.2]
  def up
    remove_column :people, :mobile_phone
    remove_column :people, :mobile_phone_unknown
    remove_column :people, :mobile_provided
    remove_column :people, :mobile_not_provided_reason
    remove_column :people, :mobile_keep_private
    remove_column :people, :home_phone_unknown
    remove_column :people, :home_phone
  end

  def down
    add_column :people, :mobile_phone, :string
    add_column :people, :mobile_phone_unknown, :boolean, default: false
    add_column :people, :mobile_provided, :string
    add_column :people, :mobile_not_provided_reason, :string
    add_column :people, :mobile_keep_private, :string
    add_column :people, :home_phone_unknown, :boolean, default: false
    add_column :people, :home_phone, :string
  end
end
