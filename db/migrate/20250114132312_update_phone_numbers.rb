class UpdatePhoneNumbers < ActiveRecord::Migration[7.2]
  def up
    rename_column :people, :mobile_phone, :phone_number
    execute <<-SQL
      UPDATE people
      SET phone_number = home_phone
      WHERE phone_number IS NULL
    SQL
    remove_column :people, :home_phone
  end

  def down
    add_column :people, :home_phone, :string
    rename_column :people, :phone_number, :mobile_phone
  end
end