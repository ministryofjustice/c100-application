class UpdateMiamExemptionMiscValues < ActiveRecord::Migration[6.0]
  def up
    Miam::MiamValueUpdate.update_miam_values!
  end

  def down
    Miam::MiamValueUpdate.undo_miam_migrate!
  end
end
