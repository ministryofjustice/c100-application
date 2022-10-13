class UpdateMiamExemptionMiscValues < ActiveRecord::Migration[6.0]
  def up
    Lib::Miam::MiamValueUpdate.update_miam_values!
  end

  def down
    Lib::Miam::MiamValueUpdate.undo_miam_migrate!
  end
end
