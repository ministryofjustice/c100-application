class UpdateMiamExemptionMiscValues < ActiveRecord::Migration[6.0]
  def up
    Miam::MiamValueUpdate.new.update_miam_values!
  end

  def down
    Miam::MiamValueUpdate.new.undo_miam_migrate!
  end
end
