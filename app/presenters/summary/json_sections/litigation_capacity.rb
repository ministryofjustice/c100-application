module Summary
  module JsonSections
    class LitigationCapacity
      attr_reader :c100_application
      attr_reader :section_hash

      alias_attribute :c100, :c100_application

      def initialize(c100_application)
        @c100_application = c100_application
        @section_hash = litigation_capacity
      end

      def litigation_capacity
        {
          litigationCapacityFactors: c100_application.reduced_litigation_capacity,
          litigationCapacityReferrals: c100_application.participation_capacity_details,
          litigationCapacityOtherFactors: c100_application.participation_other_factors_details,
          litigationCapacityOtherFactorsDetails: c100_application.participation_referral_or_assessment_details
        }
      end
    end
  end
end
