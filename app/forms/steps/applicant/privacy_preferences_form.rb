module Steps
  module Applicant
    class PrivacyPreferencesForm < BaseForm
      include ActiveModel::Validations::Callbacks

      attribute :are_contact_details_private, YesNo
      attribute :contact_details_private, Array[String]

      validates_inclusion_of :are_contact_details_private,
        in: GenericYesNo.values
      validate :at_least_one_contact_detail_preference,
        if: -> { are_contact_details_private&.yes? }

      private

      def at_least_one_contact_detail_preference
        errors.add(:contact_details_private, :blank) unless contact_details_private.reject!(&:blank?).any?
      end

      def persist!
        raise C100ApplicationNotFound unless c100_application

        applicant = c100_application.applicants.
          find_or_initialize_by(id: record_id)
        applicant.update(attributes_map)
      end
    end
  end
end
