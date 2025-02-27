module Users
  class DraftsController < ApplicationController
    before_action :authenticate_user!

    def index
      @drafts = current_user.c100_applications.order(created_at: :asc)
    end

    def resume
      # Note: there is no need for `else` because `draft_from_params`
      # will raise an exception if no application was found
      #
      if completed_application_from_params
        set_session_and_redirect(
          completed_application_from_params,
          steps_completion_confirmation_path
        )
      elsif draft_from_params
        set_session_and_redirect(
          draft_from_params,
          resume_steps_application_check_your_answers_path
        )
      end
    end

    def destroy
      draft_from_params.destroy
      redirect_to users_drafts_path, allow_other_host: true
    end

    private

    def completed_application_from_params
      @_completed_application_from_params ||= current_user.completed_applications.find_by(id: params[:id])
    end

    def draft_from_params
      @_draft_from_params ||= current_user.drafts.find_by(id: params[:id]) || (raise Errors::ApplicationNotFound)
    end

    def set_session_and_redirect(c100_application, path)
      session[:c100_application_id] = c100_application.id
      redirect_to path, allow_other_host: true
    end
  end
end
