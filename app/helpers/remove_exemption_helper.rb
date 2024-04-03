module RemoveExemptionHelper
  def remove_file_if_no_evidence(c100_application)
    return unless c100_application.document(:exemption) && c100_application.attach_evidence == "no"

    document = c100_application.document(:exemption)
    Uploader.delete_file(
      collection_ref: c100_application.files_collection_ref,
      document_key: :exemption,
      filename: document.name
    ) if document
  end
end
