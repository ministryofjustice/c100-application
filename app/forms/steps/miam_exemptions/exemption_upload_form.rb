module Steps
  module MiamExemptions
    class ExemptionUploadForm < BaseForm
      include DocumentAttachable

      validate :check_document_presence
      attribute :exemption_document, DocumentUpload

      def document_key
        :exemption
      end

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        upload_document_if_present
      end
    end
  end
end
