module Steps
  module Respondent
    class ContactDetailsForm < BaseForm
      attribute :email, :normalised_email
      attribute :email_unknown, :boolean
      attribute :phone_number, :stripped_string
      attribute :phone_number_unknown, :boolean

      validates :email, email: true, unless: :email_unknown?
      validates_presence_of  :email, unless: :email_unknown?
      validates_presence_of  :phone_number, unless: :phone_number_unknown?
      validates :phone_number, phone_number: true, unless: :phone_number_unknown?
      validates :email, unknown_respondent_input: true, if: :email_unknown?
      validates :phone_number, unknown_respondent_input: true, if: :phone_number_unknown?

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        respondent = c100_application.respondents.find_or_initialize_by(id: record_id)
        respondent.update(
          attributes_map
        )
      end
    end
  end
end
