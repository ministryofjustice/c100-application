module Steps
  module Application
    class HasCourtOrderUploadsForm < BaseForm
      attribute :has_court_order_uploads, YesNo

      validates_inclusion_of :has_court_order_uploads, in: GenericYesNo.values

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        c100_application.update(
          has_court_order_uploads: has_court_order_uploads
        )
      end
    end
  end
end
