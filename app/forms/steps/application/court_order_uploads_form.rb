module Steps
  module Application
    class CourtOrderUploadsForm < BaseForm
      include DocumentAttachable

      validate :check_document_presence
      attribute :court_order_uploads_document, DocumentUpload

      def document_key
        :court_order_uploads
      end

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        upload_document_if_present
      end
    end
  end
end
