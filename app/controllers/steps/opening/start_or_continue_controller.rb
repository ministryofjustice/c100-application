module Steps
  module Opening
    class StartOrContinueController < Steps::OpeningStepController
      skip_before_action :check_c100_application_presence, :check_application_not_completed, if: -> { PrlChange.changes_apply? }
      skip_before_action :update_navigation_stack, if: -> { PrlChange.changes_apply? }
      before_action :existing_application_warning, only: [:edit], unless: :restarting
      before_action :reset_c100_application_session, only: [:edit], if: :is_restarting
      def edit
        @form_object = StartOrContinueForm.build(current_c100_application)
      end

      def update
        update_and_advance(StartOrContinueForm)
      end

      private

      def restarting
        is_attempting_restart? && !PrlChange.changes_apply?
      end

      def is_restarting
        is_attempting_restart? && PrlChange.changes_apply?
      end
    end
  end
end
