module Steps
  module Opening
    class StartOrContinueController < Steps::OpeningStepController
      skip_before_action :check_c100_application_presence, :check_application_not_completed, :update_navigation_stack
      before_action :existing_application_warning, only: [:edit], unless: :is_changing
      before_action :reset_c100_application_session, only: [:edit], if: :is_restarting

      def edit
        @form_object = StartOrContinueForm.build(current_c100_application)
      end

      def update
        update_and_advance(StartOrContinueForm)
      end

      private

      def is_changing
        is_attempting_restart? || is_attempting_change?
      end

      def is_restarting
        is_attempting_restart?
      end
    end
  end
end
