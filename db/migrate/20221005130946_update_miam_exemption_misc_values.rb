class UpdateMiamExemptionMiscValues < ActiveRecord::Migration[6.0]
  def up
    C100App::Admin::MiamValueUpdate.update_miam_values!
  end

  def down
    C100App::Admin::MiamValueUpdate.undo_miam_migrate!
  end
end
