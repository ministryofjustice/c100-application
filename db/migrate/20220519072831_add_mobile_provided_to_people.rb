class AddMobileProvidedToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :mobile_provided, :string
  end
end
