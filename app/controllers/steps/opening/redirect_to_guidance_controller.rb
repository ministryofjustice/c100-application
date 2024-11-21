module Steps
  module Opening
    class RedirectToGuidanceController < Steps::OpeningStepController
      def show
        redirect_to 'https://privatelaw.aat.platform.hmcts.net/complete-your-application-guidance', allow_other_host: true
      end
    end
  end
end
