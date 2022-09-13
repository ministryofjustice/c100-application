module Summary
  module JsonSections
    class AllegationOfHarm < Sections::BaseJsonPresenter
      attr_reader :c100_application
      attr_reader :section_hash

      alias_attribute :c100, :c100_application

      def initialize(c100_application)
        super()
        @c100_application = c100_application
        @section_hash = allegation_of_harm
      end

      # rubocop:disable  Metrics/AbcSize, Metrics/MethodLength
      def allegation_of_harm
        {
          allegationsOfHarmYesNo: "No",
         # allegationsOfHarmDomesticAbuseYesNo: nil,
         # allegationsOfHarmOtherConcernsYesNo: nil,
         # allegationsOfHarmChildAbuseYesNo: nil,
         # allegationsOfHarmOtherConcerns: nil,
         # allegationsOfHarmOtherConcernsDetails: nil,
         # allegationsOfHarmOtherConcernsCourtActions: nil,

         physicalAbuseVictim: abuse_concern('physical'),
         emotionalAbuseVictim: abuse_concern('emotional'),
         financialAbuseVictim: abuse_concern('financial'),
         psychologicalAbuseVictim: abuse_concern('psychological'),
         sexualAbuseVictim: abuse_concern('sexual'),
         allegationsOfHarmChildAbductionYesNo: c100_application.risk_of_abduction,
         childAbductionReasons: abduction_details(:risk_details),
         previousAbductionThreats: abduction_details(:previous_attempt),
         previousAbductionThreatsDetails: abduction_details(:previous_attempt_details),
         agreeChildUnsupervisedTime: child_unsupervised,
         agreeChildSupervisedTime: child_supervised,
         agreeChildOtherContact: c100_application.concerns_contact_other,
         childrenLocationNow: abduction_details(:current_location),
         abductionPassportOfficeNotified: abduction_details(:passport_office_notified),
         abductionChildHasPassport: abduction_details(:children_have_passport),
         abductionChildPassportPosession: abduction_details(:passport_possession),
         abductionChildPassportPosessionOtherDetail: abduction_details(:passport_possession_other_details),
         abductionPreviousPoliceInvolvement: abduction_details(:previous_attempt_agency_involved),
         abductionPreviousPoliceInvolvementDetails: abduction_details(:previous_attempt_agency_details),
         allegationsOfHarmSubstanceAbuseYesNo: c100_application.substance_abuse,
         ordersNonMolestation: court_order(:non_molestation),
         ordersNonMolestationDateIssued: court_order(:non_molestation_issue_date),
         # ordersNonMolestationEndDate: nil,
         ordersNonMolestationCurrent: court_order(:non_molestation_is_current),
         ordersNonMolestationCourtName: court_order(:non_molestation_court_name),
         ordersForcedMarriageProtectionDateIssued: court_order(:forced_marriage_protection_issue_date),
         # ordersForcedMarriageProtectionEndDate: nil,
         ordersForcedMarriageProtection: court_order(:forced_marriage_protection),
         ordersForcedMarriageProtectionCurrent: court_order(:forced_marriage_protection_is_current),
         ordersForcedMarriageProtectionCourtName: court_order(:forced_marriage_protection_court_name),
         ordersRestrainingDateIssued: court_order(:restraining_issue_date),
         # ordersRestrainingEndDate: nil,
         ordersRestrainingCourtName: court_order(:restraining_court_name),
         ordersRestrainingCurrent: court_order(:restraining_is_current),
         ordersRestraining: court_order(:restraining),
         ordersOtherInjunctiveDateIssued: court_order(:injunctive_issue_date),
         # ordersOtherInjunctiveEndDate: court_order(:restraining),
         ordersOtherInjunctiveCurrent: court_order(:injunctive_is_current),
         ordersOtherInjunctiveCourtName: court_order(:injunctive_court_name),
         ordersOtherInjunctive: court_order(:injunctive),

         ordersOccupation: court_order(:occupation),
         ordersOccupationCurrent: court_order(:occupation_is_current),
         ordersOccupationCourtName: court_order(:occupation_court_name),
         ordersOccupationDateIssued: court_order(:occupation_issue_date),
         # ordersOccupationEndDate: nil,
         ordersUndertakingInPlaceDateIssued: court_order(:undertaking_issue_date),
         # ordersUndertakingInPlaceEndDate: "null",
         ordersUndertakingInPlaceCourtName: court_order(:undertaking_court_name),
         ordersUndertakingInPlaceCurrent: court_order(:undertaking_is_current),
         ordersUndertakingInPlace: court_order(:undertaking),
          # behaviours: []
        }
      end
      # rubocop:enable  Metrics/AbcSize, Metrics/MethodLength

      def abuse_concern(key)
        abuse = c100_application.abuse_concerns.find_by(kind: key)
        abuse.answer if abuse.present?
      end

      def court_order(key)
        return if c100_application.court_order.blank?
        c100_application.court_order.send(key)
      end

      def abduction_details(key)
        return unless c100_application.abduction_detail
        return c100_application.abduction_detail.send(key).join(', ') if key == :passport_possession
        c100_application.abduction_detail.send(key)
      end

      def child_unsupervised
        return if c100_application.concerns_contact_type.blank?
        unsupervised = ConcernsContactType.new(:unsupervised).value
        yes_no(c100_application.concerns_contact_type == unsupervised.to_s)
      end

      def child_supervised
        return if c100_application.concerns_contact_type.blank?
        supervised = ConcernsContactType.new(:supervised).value
        yes_no(c100_application.concerns_contact_type == supervised.to_s)
      end
    end
  end
end
