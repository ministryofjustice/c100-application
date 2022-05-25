class AddMobileNotProvidedReasonToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :mobile_not_provided_reason, :string
  end
end
