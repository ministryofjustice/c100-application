module Steps
  module Respondent
    class PrivacyPreferencesForm < BaseForm

      attribute :are_contact_details_private, YesNo

      validates_inclusion_of :are_contact_details_private, in: GenericYesNo.values

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        respondent = c100_application.respondents.find_or_initialize_by(id: record_id)
        respondent.update(
          are_contact_details_private:
        )
      end
    end
  end
end
