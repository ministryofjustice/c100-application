module Steps
  module Abduction
    class RiskDetailsForm < BaseForm
      include HasOneAssociationForm

      has_one_association :abduction_detail

      attribute :risk_details, :string
      attribute :current_location, :string

      validates_presence_of :risk_details,
                            :current_location

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        record_to_persist.update(
          attributes_map
        )
      end
    end
  end
end
