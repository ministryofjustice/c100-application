module Steps
  module Opening
    class StartOrContinueController < Steps::OpeningStepController
      # skip_before_action :check_c100_application_presence
      # before_action :existing_application_warning, only: [:edit], unless: -> { params[:new].present? }
      # before_action :reset_c100_application_session, only: [:edit], if: -> { params[:new].present? }
      # include StartingPointStep
      #
      # def edit
      #   @form_object = StartOrContinueForm.build(current_c100_application)
      # end
      #
      # def update
      #   update_and_advance(StartOrContinueForm)
      # end
    end
  end
end
