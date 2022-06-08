class AddParentalResponsibilityToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :parental_responsibility, :string
  end
end
