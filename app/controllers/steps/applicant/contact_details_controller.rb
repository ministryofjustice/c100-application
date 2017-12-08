module Steps
  module Applicant
    class ContactDetailsController < Steps::ApplicantStepController
      include CrudStep

      def edit
        @form_object = ContactDetailsForm.build(
          current_record, c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(
          ContactDetailsForm,
          record: current_record,
          as: :contact_details
        )
      end

      private

      def record_collection
        @_record_collection ||= current_c100_application.applicants
      end
    end
  end
end
