module Steps
  module Applicant
    class RefugeForm < BaseForm
      include ActiveModel::Validations::Callbacks

      attribute :refuge, YesNo

      validates_inclusion_of :refuge, in: GenericYesNo.values

      validate :refuge_with_private_address, if: -> { refuge.yes? }

      private

      def refuge_with_private_address
        current_applicant = c100_application.applicants.find_or_initialize_by(id: record_id)

        errors.add(:refuge, :without_private_address) unless current_applicant.contact_details_private.include? "address"
      end

      def persist!
        raise C100ApplicationNotFound unless c100_application

        applicant = c100_application.applicants.find_or_initialize_by(id: record_id)
        applicant.update(attributes_map)
      end
    end
  end
end
