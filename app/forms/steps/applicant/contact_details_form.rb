module Steps
  module Applicant
    class ContactDetailsForm < BaseForm
      include ActiveModel::Validations::Callbacks

      attribute :email, StrippedString
      attribute :phone_number, StrippedString
      attribute :voicemail_consent, YesNo
      attribute :email_provided, YesNo
      attribute :phone_number_provided, YesNo
      attribute :phone_number_not_provided_reason, StrippedString

      # Note: we validate presence of these fields, but allow the applicant to enter
      # free text in case they do not want to disclose their phone or email address.
      # That is why we do not perform any further validation, other than presence
      # (do not validate the format of the phone or email, etc.)
      #

      validates_inclusion_of :email_provided, in: GenericYesNo.values
      validates :email, email: true, if: proc { |o| validate_email_value?(o) }

      validates_inclusion_of :phone_number_provided, in: GenericYesNo.values
      validates_presence_of :phone_number, if: proc { |o| validate_phone_value?(o) }
      validates :phone_number, phone_number: true, if: proc { |o| validate_phone_value?(o) }

      validates_presence_of :phone_number_not_provided_reason,
                            if: proc { |o| validate_phone_not_provided_reason?(o) }

      validates_inclusion_of :voicemail_consent, in: GenericYesNo.values, if: proc { |o| validate_phone_value?(o) }
      validate :voicemail_without_phone

      private

      def attributes_map
        super().tap do |hsh|
          hsh[:email] = nil unless email_provided.yes?
          hsh[:phone_number] = nil unless phone_number_provided.yes?
          hsh[:phone_number_not_provided_reason] = nil if phone_number_provided.yes?
        end
      end

      def persist!
        raise C100ApplicationNotFound unless c100_application

        applicant = c100_application.applicants.find_or_initialize_by(id: record_id)
        applicant.update(attributes_map)
      end

      def voicemail_without_phone
        errors.add(:voicemail_consent, :conflict) if voicemail_consent&.yes? && phone_number_provided&.no?
      end

      def validate_email_value?(o)
        o.email_provided && GenericYesNo.new(o.email_provided).yes?
      end

      def validate_phone_value?(o)
        o.phone_number_provided && GenericYesNo.new(o.phone_number_provided).yes?
      end

      def validate_phone_not_provided_reason?(o)
        o.phone_number_provided && GenericYesNo.new(o.phone_number_provided).no?
      end
    end
  end
end
