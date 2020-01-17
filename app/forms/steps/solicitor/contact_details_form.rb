module Steps
  module Solicitor
    class ContactDetailsForm < BaseForm
      include HasOneAssociationForm

      has_one_association :solicitor

      attribute :address, StrippedString
      attribute :dx_number, StrippedString
      attribute :phone_number, StrippedString
      attribute :fax_number, StrippedString
      attribute :email, NormalisedEmail

      validates_presence_of :address, :phone_number
      validates :email, email: true, allow_blank: true

      # Used to present the solicitor's name in the view
      delegate :full_name, to: :record_to_persist

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        record_to_persist.update(
          attributes_map
        )
      end
    end
  end
end
