module Steps
  module OtherParty
    class IdentityPreferencesForm < BaseForm
      include ActiveModel::Validations::Callbacks

      attribute :are_identity_details_private, YesNo

      validates_inclusion_of :are_identity_details_private, in: GenericYesNo.values

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        party = c100_application.other_parties.find_or_initialize_by(id: record.id)
        party.update({**attributes_map})
      end
    end
  end
end
