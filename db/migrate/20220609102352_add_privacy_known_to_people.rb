class AddPrivacyKnownToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :privacy_known, :string
  end
end
