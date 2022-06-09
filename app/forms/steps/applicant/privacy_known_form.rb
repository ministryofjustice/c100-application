module Steps
  module Applicant
    class PrivacyKnownForm < BaseForm
      include ActiveModel::Validations::Callbacks

      attribute :privacy_known, YesNoUnknown

      validates_inclusion_of :privacy_known, in: GenericYesNoUnknown.values

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        applicant = c100_application.applicants.find_or_initialize_by(id: record_id)
        applicant.update(attributes_map)
      end
    end
  end
end
