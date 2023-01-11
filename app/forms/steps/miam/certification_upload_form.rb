module Steps
  module Miam
    class CertificationUploadForm < BaseForm
      include DocumentAttachable

      validate :check_document_presence
      attribute :miam_certificate_document, DocumentUpload

      def document_key
        :miam_certificate
      end

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        upload_document_if_present
      end
    end
  end
end
