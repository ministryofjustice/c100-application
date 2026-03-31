module Steps
  module Children
    class AdditionalDetailsForm < BaseForm
      attribute :children_known_to_authorities, :yes_no_unknown
      attribute :children_known_to_authorities_details, :string
      attribute :children_protection_plan, :yes_no_unknown

      validates_inclusion_of :children_known_to_authorities, in: GenericYesNoUnknown.values
      validates_inclusion_of :children_protection_plan,      in: GenericYesNoUnknown.values

      validates_presence_of :children_known_to_authorities_details, if: -> { children_known_to_authorities&.yes? }

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        c100_application.update(
          attributes_map.merge(
            children_known_to_authorities_details: (children_known_to_authorities_details if children_known_to_authorities.yes?)
          )
        )
      end
    end
  end
end
