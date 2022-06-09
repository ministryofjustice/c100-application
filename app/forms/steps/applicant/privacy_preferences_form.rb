module Steps
  module Applicant
    class PrivacyPreferencesForm < BaseForm
      include ActiveModel::Validations::Callbacks

      attribute :are_contact_details_private, YesNo
      attribute :contact_details_private, Array[String]

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        applicant = c100_application.applicants.find_or_initialize_by(id: record_id)
        applicant.update(attributes_map)
      end
    end
  end
end
