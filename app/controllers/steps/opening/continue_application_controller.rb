module Steps
  module Opening
    class ContinueApplicationController < Steps::OpeningStepController

      def edit
        @form_object = ContinueApplicationForm.build(current_c100_application)
      end

      def update
        update_and_advance(ContinueApplicationForm, as: :continue_application)
      end
    end
  end
end
