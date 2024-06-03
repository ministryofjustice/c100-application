module Steps
  module MiamExemptions
    class ExemptionDetailsForm < BaseForm
      attribute :exemption_details, String

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        c100_application.update(
          exemption_details:
        )
      end
    end
  end
end
