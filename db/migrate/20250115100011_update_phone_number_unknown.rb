class UpdatePhoneNumberUnknown < ActiveRecord::Migration[7.2]
  def up
    rename_column :people, :mobile_phone_unknown, :phone_number_unknown

    execute <<-SQL
      UPDATE people
      SET phone_number_unknown = true
      WHERE phone_number_unknown = false AND home_phone_unknown = true
    SQL

    remove_column :people, :home_phone_unknown
  end

  def down
    add_column :people, :home_phone_unknown, :boolean, default: false
    rename_column :people, :phone_number_unknown, :mobile_phone_unknown
  end
end