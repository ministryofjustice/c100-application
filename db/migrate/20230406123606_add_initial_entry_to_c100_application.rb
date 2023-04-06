class AddInitialEntryToC100Application < ActiveRecord::Migration[7.0]
  def change
    add_column :c100_applications, :start_or_continue, :string
    add_column :c100_applications, :is_legal_representative, :string
    add_column :c100_applications, :has_myhmcts_account, :string
    add_column :c100_applications, :platform, :string
  end
end
