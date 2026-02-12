module Steps
  module Application
    class ExistingCourtOrderUploadForm < BaseForm
      include DocumentAttachable

      validate :check_document_presence
      attribute :existing_court_order_document, DocumentUpload

      def document_key
        :existing_court_order
      end

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        upload_document_if_present
      end
    end
  end
end
