module Steps
  module Application
    class CourtOrderUploadsForm < BaseForm
      include DocumentAttachable

      attribute :has_court_order_uploads, YesNo

      validates_inclusion_of :has_court_order_uploads,  in: GenericYesNo.values

      validate :check_document_presence,
        if: -> { has_court_order_uploads&.yes? }
      attribute :court_order_document, DocumentUpload

      def document_key
        :court_order
      end

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        upload_document_if_present
      end
    end
  end
end
