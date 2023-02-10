module Steps
  module Opening
    class RedirectToMyHmctsController < Steps::OpeningStepController
      skip_before_action :update_navigation_stack

      def show
        redirect_to 'https://manage-case.platform.hmcts.net/cases'
      end
    end
  end
end
