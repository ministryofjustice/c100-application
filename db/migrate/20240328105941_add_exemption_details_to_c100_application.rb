class AddExemptionDetailsToC100Application < ActiveRecord::Migration[7.1]
  def change
    add_column :c100_applications, :exemption_details, :text
  end
end
