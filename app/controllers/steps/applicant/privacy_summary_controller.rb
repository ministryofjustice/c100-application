module Steps
  module Applicant
    class PrivacySummaryController < Steps::ApplicantStepController
      def show
        @current_record = current_record
      end
    end
  end
end
