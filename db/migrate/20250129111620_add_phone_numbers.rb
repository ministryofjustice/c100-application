class AddPhoneNumbers < ActiveRecord::Migration[7.2]
  def up
    add_column :people, :phone_number, :string
    execute <<-SQL
      UPDATE people
      SET phone_number =
        CASE
          WHEN home_phone IS NOT NULL THEN home_phone
          WHEN mobile_phone IS NOT NULL THEN mobile_phone
          ELSE NULL
        END
    SQL

    add_column :people, :phone_number_unknown, :boolean, default: false

    execute <<-SQL
      UPDATE people
      SET phone_number_unknown =
        CASE
          WHEN home_phone_unknown IS NOT NULL THEN home_phone_unknown
          WHEN mobile_phone_unknown IS NOT NULL THEN mobile_phone_unknown
          ELSE phone_number_unknown
        END
    SQL

    add_column :people, :phone_number_provided, :string
    add_column :people, :phone_number_not_provided_reason, :string

    execute <<-SQL
      UPDATE people
      SET phone_keep_private = mobile_keep_private
      WHERE phone_keep_private IS NULL AND mobile_keep_private IS NOT NULL
    SQL
  end

  def down
    remove_column :people, :phone_number
    remove_column :people, :phone_number_unknown
    remove_column :people, :phone_number_provided
    remove_column :people, :phone_number_not_provided_reason
  end
end
