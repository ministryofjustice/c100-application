class AddMyHmctsToC100Applications < ActiveRecord::Migration[7.0]
  def change
    add_column :c100_applications, :is_solicitor, :string
    add_column :c100_applications, :use_my_hmcts, :string
  end
end
