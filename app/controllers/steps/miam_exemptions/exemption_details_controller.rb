module Steps
  module MiamExemptions
    class ExemptionDetailsController < Steps::MiamExemptionsStepController
      def edit
        @form_object = ExemptionDetailsForm.new(
          c100_application: current_c100_application,
          exemption_details: current_c100_application.exemption_details
        )
      end

      def update
        update_and_advance(ExemptionDetailsForm, as: :exemption_details)
      end
    end
  end
end
