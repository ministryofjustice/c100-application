module Steps
  module Opening
    class StartOrContinueController < Steps::OpeningStepController
      skip_before_action :check_c100_application_presence, :update_navigation_stack
      before_action :existing_application_warning
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
