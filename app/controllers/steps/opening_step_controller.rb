module Steps
  class OpeningStepController < StepController
    skip_before_action :check_application_not_screening

    private

    def decision_tree_class
      C100App::OpeningDecisionTree
    end

    def not_enough_progress?
      !(current_c100_application.navigation_stack.size > 2 &&
      %w[screening completed].exclude?(current_c100_application.status))
    end

    def is_attempting_restart?
      params.dig(:steps_opening_start_or_continue_form, :new).present?
    end

    def existing_application_warning
      return unless current_c100_application
      return if not_enough_progress?
      return if is_attempting_restart?

      redirect_to steps_opening_warning_path
    end

  end
end
