class AddCohabitWithOtherToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :cohabit_with_other, :string
  end
end
