class AddExemptionReasonsAndAttachEvidenceToC100Application < ActiveRecord::Migration[7.1]
  def change
    add_column :c100_applications, :exemption_reasons, :text
    add_column :c100_applications, :attach_evidence, :string
  end
end
