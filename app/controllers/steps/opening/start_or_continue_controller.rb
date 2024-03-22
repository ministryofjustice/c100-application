module Steps
  module Opening
    class StartOrContinueController < Steps::OpeningStepController
      skip_before_action :check_c100_application_presence, if: -> { OpeningChange.changes_apply? }
      skip_before_action :update_navigation_stack, if: -> { OpeningChange.changes_apply? }
      before_action :existing_application_warning, only: [:edit], unless: lambda {
                                                                            params[:new].present? && !OpeningChange.changes_apply?
                                                                          }
      before_action :reset_c100_application_session, only: [:edit], if: lambda {
                                                                          params[:new].present? && OpeningChange.changes_apply?
                                                                        }

      def edit
        @form_object = StartOrContinueForm.build(current_c100_application)
      end

      def update
        update_and_advance(StartOrContinueForm)
      end
    end
  end
end
