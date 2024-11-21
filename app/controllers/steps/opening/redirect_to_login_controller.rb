module Steps
  module Opening
    class RedirectToLoginController < Steps::OpeningStepController
      def show
        redirect_to new_user_session_path, allow_other_host: true
      end
    end
  end
end
