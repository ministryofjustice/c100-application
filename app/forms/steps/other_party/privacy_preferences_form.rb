module Steps
  module OtherParty
    class PrivacyPreferencesForm < BaseForm
      include ActiveModel::Validations::Callbacks

      attribute :are_contact_details_private, YesNo
      attribute :privacy_known, YesNo

      validates_inclusion_of :are_contact_details_private, in: GenericYesNo.values

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        party = c100_application.other_parties.find_or_initialize_by(id: record.person.id)
        party.update({**attributes_map}.merge(privacy_known: 'yes'))
      end
    end
  end
end
