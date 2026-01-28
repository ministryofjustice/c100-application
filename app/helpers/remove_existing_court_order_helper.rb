module RemoveExistingCourtOrderHelper
  def remove_file_if_no_uploadable(c100_application)
    return unless c100_application.document(:existing_court_order) && c100_application.existing_court_order_uploadable == 'no'

    document = c100_application.document(:existing_court_order)
    Uploader.delete_file(
      collection_ref: c100_application.files_collection_ref,
      document_key: :existing_court_order,
      filename: document.name
    ) if document
  end
end
