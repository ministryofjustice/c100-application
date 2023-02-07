module Steps
  module Applicant
    class ContactDetailsForm < BaseForm
      include ActiveModel::Validations::Callbacks

      attribute :email, StrippedString
      attribute :home_phone, StrippedString
      attribute :mobile_phone, StrippedString
      attribute :voicemail_consent, YesNo
      attribute :email_provided, YesNo
      attribute :mobile_provided, YesNo
      attribute :mobile_not_provided_reason, StrippedString

      # Note: we validate presence of these fields, but allow the applicant to enter
      # free text in case they do not want to disclose their phone or email address.
      # That is why we do not perform any further validation, other than presence
      # (do not validate the format of the phone or email, etc.)
      #
      validates_inclusion_of :email_provided, in: GenericYesNo.values

      validates :email, email: true, if: proc { |o| validate_email_value?(o) }

      validates_inclusion_of :mobile_provided, in: GenericYesNo.values

      validates_presence_of :mobile_phone, if: proc { |o| validate_mobile_value?(o) }
      validates :mobile_phone, phone_number: true, if: proc { |o| validate_mobile_value?(o) }

      validates_presence_of :mobile_not_provided_reason,
                            if: proc { |o| validate_mobile_not_provided_reason?(o) }

      validates :home_phone, phone_number: true, allow_blank: true

      validates_inclusion_of :voicemail_consent, in: GenericYesNo.values, if: proc { |o| validate_mobile_value?(o) }

      validates_presence_of :mobile_phone, if: proc { |o| validate_voicemail_mobile?(o) }
      validates_presence_of :home_phone, if: proc { |o| validate_voicemail_home?(o) }

      private

      def attributes_map
        super().tap do |hsh|
          hsh[:email] = nil unless email_provided.yes?
          hsh[:mobile_phone] = nil unless mobile_provided.yes?
          hsh[:mobile_not_provided_reason] = nil unless mobile_provided.yes?
        end
      end

      def persist!
        raise C100ApplicationNotFound unless c100_application

        applicant = c100_application.applicants.find_or_initialize_by(id: record_id)
        applicant.update(attributes_map)
      end

      def validate_email_value?(o)
        o.email_provided && GenericYesNo.new(o.email_provided).yes?
      end

      def validate_mobile_value?(o)
        o.mobile_provided && GenericYesNo.new(o.mobile_provided).yes?
      end

      def validate_mobile_not_provided_reason?(o)
        o.mobile_provided && GenericYesNo.new(o.mobile_provided).no?
      end

      def validate_voicemail_mobile?(o)
        o.voicemail_consent && validate_mobile_value?(o) && GenericYesNo.new(o.voicemail_consent).yes? && o.home_phone == ""
      end

      def validate_voicemail_home?(o)
        o.voicemail_consent && GenericYesNo.new(o.voicemail_consent).yes? && o.mobile_phone == ""
      end
    end
  end
end
