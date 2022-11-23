module DocumentAttachable
  extend ActiveSupport::Concern

  included do
    validate :valid_uploaded_file
  end

  # :nocov:
  def document_key
    raise 'implement in the class including this module'
  end
  # :nocov:

  private

  def document_attribute
    [document_key, '_document'].join.to_sym
  end

  def document
    self[document_attribute]
  end

  def document_provided?
    c100_application&.documents(document_key)&.any? || document.present?
  end

  def check_document_presence
    errors.add(document_attribute, :blank) unless c100_application.nil? || document_provided?
  end

  def valid_uploaded_file
    return true if document.nil? || document.valid?
    retrieve_document_errors
  end

  def upload_document_if_present
    return true if document.nil?

    document.upload!(document_key: document_key, collection_ref: c100_application.files_collection_ref)
    retrieve_document_errors

    errors.empty?
  end

  def retrieve_document_errors
    document.errors.each do |error|
      errors.add(document_attribute, error.type) # CHANGED_HERE
    end
  end
end