module Steps
  module Applicant
    class AddressDetailsForm < AddressBaseForm
      attribute :residence_requirement_met, YesNo
      validates_inclusion_of :residence_requirement_met, in: GenericYesNo.values

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        applicant = c100_application.applicants.find_or_initialize_by(id: record_id)
        applicant.update(
          update_values
        )
      end
    end
  end
end
