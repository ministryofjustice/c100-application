module Steps
  module Opening
    class RedirectToMyHmctsController < Steps::OpeningStepController
      def show
        redirect_to 'https://manage-case.platform.hmcts.net/cases', allow_other_host: true
      end
    end
  end
end
