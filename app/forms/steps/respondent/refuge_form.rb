module Steps
  module Respondent
    class RefugeForm < BaseForm
      include ActiveModel::Validations::Callbacks

      attribute :refuge, YesNoUnknown

      validates_inclusion_of :refuge, in: GenericYesNoUnknown.values

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        respondent = c100_application.respondents.find_or_initialize_by(id: record.id)
        respondent.update(attributes_map)
      end
    end
  end
end
