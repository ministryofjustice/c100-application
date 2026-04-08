module Steps
  module Solicitor
    class ContactDetailsForm < BaseForm
      include HasOneAssociationForm

      has_one_association :solicitor

      attribute :email, :normalised_email
      attribute :phone_number, :stripped_string
      attribute :dx_number, :stripped_string
      attribute :email_provided, :yes_no

      validates :email, email: true, allow_blank: true
      validates :phone_number, phone_number: true
      validates :dx_number, sensible_dx: true

      validates_presence_of :email, :phone_number

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
