module Steps
  module AbuseConcerns
    class ContactForm < BaseForm
      attribute :concerns_contact_type, :string
      attribute :concerns_contact_other, :yes_no

      def self.choices
        ConcernsContactType.string_values
      end

      validates_inclusion_of :concerns_contact_type,  in: choices
      validates_inclusion_of :concerns_contact_other, in: GenericYesNo.values

      private

      def concerns_contact_type_value
        ConcernsContactType.new(concerns_contact_type)
      end

      def persist!
        raise C100ApplicationNotFound unless c100_application

        c100_application.update(
          concerns_contact_type: concerns_contact_type_value,
          concerns_contact_other:
        )
      end
    end
  end
end
