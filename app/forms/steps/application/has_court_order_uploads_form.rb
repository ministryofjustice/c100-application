module Steps
  module Application
    class HasCourtOrderUploadsForm < BaseForm
      attribute :has_court_order_uploads, YesNo

      validates_inclusion_of :has_court_order_uploads, in: GenericYesNo.values

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        # remove files if user changes yes to no.
        if has_court_order_uploads == GenericYesNo.new(:no)
          c100_application.documents(:court_order_uploads).each do |upload|
            Uploader.delete_file({
                                   collection_ref: c100_application.files_collection_ref,
              document_key: :court_order_uploads,
              filename: upload.name
                                 })
          end
        end
        c100_application.update(
          has_court_order_uploads: has_court_order_uploads
        )
      end
    end
  end
end
