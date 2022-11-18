class AddFilesCollectionRefToC100Application < ActiveRecord::Migration[7.0]
  def change
    add_column :c100_applications, :files_collection_ref, :uuid, default: -> { "uuid_generate_v4()" }
  end
end
