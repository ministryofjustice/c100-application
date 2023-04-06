module Steps
  module Opening
    class StartOrContinueController < Steps::OpeningStepController
      include StartingPointStep

      def edit
        @form_object = StartOrContinueForm.build(current_c100_application)
      end

      def update
        update_and_advance(StartOrContinueForm)
      end
    end
  end
end
