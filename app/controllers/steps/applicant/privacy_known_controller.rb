module Steps
  module Applicant
    class PrivacyKnownController < Steps::ApplicantStepController
      def edit
        @form_object = PrivacyKnownForm.build(
          current_record, c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(
          PrivacyKnownForm,
          record: current_record,
          as: :privacy_known
        )
      end
    end
  end
end
