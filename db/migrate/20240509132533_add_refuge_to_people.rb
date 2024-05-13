class AddRefugeToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :refuge, :string
  end
end
