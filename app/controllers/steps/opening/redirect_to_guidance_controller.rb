module Steps
  module Opening
    class RedirectToGuidanceController < Steps::OpeningStepController
      def show
        redirect_to 'https://www.apply-to-court-about-child-arrangements-c100.service.gov.uk/complete-your-application-guidance', allow_other_host: true
      end
    end
  end
end
