module Steps
  module OtherParty
    class AddressDetailsForm < AddressBaseForm
      validates_presence_of :country, unless: :address_unknown?

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        party = c100_application.other_parties.find_or_initialize_by(id: record_id)
        party.update(
          address_values
        )
      end
    end
  end
end
