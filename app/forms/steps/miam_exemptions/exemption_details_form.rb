module Steps
  module MiamExemptions
    class ExemptionDetailsForm < BaseForm
      attribute :exemption_details, String

      validates_presence_of :exemption_details

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
