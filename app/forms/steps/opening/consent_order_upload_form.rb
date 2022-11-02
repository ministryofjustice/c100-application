module Steps
  module Opening
    class ConsentOrderUploadForm < BaseForm
      include DocumentAttachable

      attribute :draft_consent_order_document, DocumentUpload
  
      def document_key
        :draft_consent_order
      end

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        upload_document_if_present
      end
    end
  end
end
