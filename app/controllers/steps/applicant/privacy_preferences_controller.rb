module Steps
  module Applicant
    class PrivacyPreferencesController < Steps::ApplicantStepController
      def edit
        @form_object = PrivacyPreferencesForm.build(
          current_record, c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(
          PrivacyPreferencesForm,
          record: current_record,
          as: :privacy_preferences
        )
      end
    end
  end
end
