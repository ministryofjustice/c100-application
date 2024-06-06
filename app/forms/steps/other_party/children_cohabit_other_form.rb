module Steps
  module OtherParty
    class ChildrenCohabitOtherForm < BaseForm

      attribute :cohabit_with_other, YesNo

      validates_inclusion_of :cohabit_with_other, in: GenericYesNo.values

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        party = c100_application.other_parties.find_or_initialize_by(id: record.person.id)
        party.update(
          cohabit_with_other:,
          privacy_known: cohabit_with_other == GenericYesNo::YES ? party.privacy_known : nil,
          are_contact_details_private: cohabit_with_other == GenericYesNo::YES ? party.are_contact_details_private : nil,
        )
      end
    end
  end
end
