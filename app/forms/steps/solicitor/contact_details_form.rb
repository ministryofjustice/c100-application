module Steps
  module Solicitor
    class ContactDetailsForm < BaseForm
      include HasOneAssociationForm

      has_one_association :solicitor

      attribute :email, NormalisedEmail
      attribute :phone_number, StrippedString
      attribute :fax_number, StrippedString
      attribute :dx_number, StrippedString
      attribute :email_provided, YesNo

      validates_inclusion_of :email_provided, in: GenericYesNo.values
      validates :email, email: true, if: proc { |o| o.email_provided && GenericYesNo.new(o.email_provided).yes? }
      validates_presence_of :phone_number

      # Used to present the solicitor's name in the view
      delegate :full_name, to: :record_to_persist

      private

      def attributes_map
        super().tap do |hsh|
          hsh[:email] = nil unless email_provided.yes?
        end
      end

      def persist!
        raise C100ApplicationNotFound unless c100_application

        record_to_persist.update(
          attributes_map
        )
      end
    end
  end
end
