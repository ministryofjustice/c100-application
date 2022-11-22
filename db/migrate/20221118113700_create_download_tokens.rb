class CreateDownloadTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :download_tokens, id: :uuid do |t|
      t.string :token, null: false, index: {unique: true}
      t.string :key, null: false
      t.references :c100_application, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
