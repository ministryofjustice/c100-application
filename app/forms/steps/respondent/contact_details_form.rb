module Steps
  module Respondent
    class ContactDetailsForm < BaseForm
      attribute :email, NormalisedEmail
      attribute :email_unknown, Boolean
      attribute :home_phone, StrippedString
      attribute :mobile_phone, StrippedString

      validates :email, email: true, allow_blank: true

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
