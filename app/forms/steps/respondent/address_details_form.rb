module Steps
  module Respondent
    class AddressDetailsForm < AddressBaseForm
      validates_inclusion_of :residence_requirement_met, in: GenericYesNoUnknown.values

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        respondent = c100_application.respondents.find_or_initialize_by(id: record_id)
        respondent.update(
          update_values
        )
      end
    end
  end
end
