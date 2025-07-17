module Steps
  module Application
    class BenefitsUploadForm < BaseForm
      include DocumentAttachable

      validate :check_document_presence
      attribute :benefits_evidence_document, DocumentUpload

      def document_key
        :benefits_evidence
      end

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        upload_document_if_present
      end
    end
  end
end
