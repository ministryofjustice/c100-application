module Steps
  module Application
    class LitigationCapacityDetailsForm < BaseForm
      attribute :participation_capacity_details, :string
      attribute :participation_referral_or_assessment_details, :string
      attribute :participation_other_factors_details, :string

      def persist!
        raise C100ApplicationNotFound unless c100_application

        c100_application.update(
          **attributes_map
        )
      end
    end
  end
end
