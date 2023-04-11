module Steps
  module Opening
    class RedirectToGuidanceController < Steps::OpeningStepController
      
      def show
        redirect_to 'https://apply-to-court-about-child-arrangements-c100.service.gov.uk/complete-your-application-guidance'
      end
    end
  end
end
