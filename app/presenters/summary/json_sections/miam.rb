module Summary
  module JsonSections
    class Miam
      attr_reader :c100_application
      attr_reader :section_hash

      alias_attribute :c100, :c100_application

      def initialize(c100_application)
        @c100_application = c100_application
        @section_hash = miam
      end

      def miam
        {
          applicantAttendedMiam: c100_application.miam_attended,
          claimingExemptionMiam: c100_application.miam_mediator_exemption,
          # familyMediatorMiam: nil,
          miamExemptionsChecklist: miam_list(:misc),
          miamDomesticViolenceChecklist:  miam_list(:domestic),
          miamUrgencyReasonChecklist: miam_list(:urgency),
          miamPreviousAttendanceChecklist: miam_list(:adr),
          # miamOtherGroundsChecklist: nil,
        }
        # mediatorRegistrationNumber1: nil,
        # familyMediatorServiceName1: nil,
        # soleTraderName1: nil
      end

      def miam_list(key)
        @c100_application.miam_exemption&.send(key)&.join(', ')
      end
    end
  end
end
