class UpdatePhonePrivacyAndProvidedColumns < ActiveRecord::Migration[7.2]
  def up
    execute <<-SQL
      UPDATE people
      SET phone_keep_private = mobile_keep_private
      WHERE phone_keep_private IS NULL AND mobile_keep_private IS NOT NULL
    SQL

    remove_column :people, :mobile_keep_private
    rename_column :people, :mobile_provided, :phone_number_provided
    rename_column :people, :mobile_not_provided_reason, :phone_number_not_provided_reason
  end

  def down
    add_column :people, :mobile_keep_private, :string
    rename_column :people, :phone_number_provided, :mobile_provided
    rename_column :people, :phone_number_not_provided_reason, :mobile_not_provided_reason
  end
end