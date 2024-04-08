module Steps
  module MiamExemptions
    class ExemptionReasonsController < Steps::MiamExemptionsStepController
      def edit
        @form_object = ExemptionReasonsForm.new(
          c100_application: current_c100_application,
          exemption_reasons: current_c100_application.exemption_reasons,
          attach_evidence: current_c100_application.attach_evidence
        )
      end

      def update
        update_and_advance(ExemptionReasonsForm)
      end
    end
  end
end
