module Steps
  module HelpWithFees
    class HelpPayingController < Steps::HelpWithFeesStepController
      def edit
        @form_object = HelpPayingForm.new(
          c100_application: current_c100_application,
          help_paying: current_c100_application.help_paying,
          hwf_reference_number: current_c100_application.hwf_reference_number
        )
      end

      def update
        update_and_advance(HelpPayingForm)
      end
    end
  end
end
