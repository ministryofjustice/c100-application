class CopyMobileProvided < ActiveRecord::Migration[7.2]
  def change
    execute <<-SQL
      UPDATE people
      SET phone_number_provided = mobile_provided
      WHERE mobile_provided IS NOT NULL
    SQL

    execute <<-SQL
      UPDATE people
      SET phone_number_not_provided_reason = mobile_not_provided_reason
      WHERE mobile_not_provided_reason IS NOT NULL
    SQL
  end
end
