module Steps
  module OtherParty
    class RefugeForm < BaseForm
      include ActiveModel::Validations::Callbacks

      attribute :refuge, YesNo

      validates_inclusion_of :refuge, in: GenericYesNo.values

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        party = c100_application.other_parties.find_or_initialize_by(id: record.person.id)
        party.update(attributes_map)
      end
    end
  end
end
