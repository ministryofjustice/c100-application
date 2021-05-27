module Steps
  module Applicant
    class ContactDetailsForm < BaseForm
      attribute :email, StrippedString
      attribute :home_phone, StrippedString
      attribute :mobile_phone, StrippedString
      attribute :voicemail_consent, YesNo
      attribute :email_provided, YesNo

      # Note: we validate presence of these fields, but allow the applicant to enter
      # free text in case they do not want to disclose their phone or email address.
      # That is why we do not perform any further validation, other than presence
      # (do not validate the format of the phone or email, etc.)
      #
      validates_inclusion_of :email_provided, in: GenericYesNo.values

      validates :email, email: true, if: Proc.new { |o| o.email_provided && GenericYesNo.new(o.email_provided).yes? }
      validates_presence_of :mobile_phone

      validates_inclusion_of :voicemail_consent, in: GenericYesNo.values

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        applicant = c100_application.applicants.find_or_initialize_by(id: record_id)
        applicant.update(
          attributes_map.tap do |hsh|
            hsh[:email] = nil unless GenericYesNo.new(email_provided).yes?
          end
        )
      end
    end
  end
end
