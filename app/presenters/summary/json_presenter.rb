module Summary
  class JsonPresenter
    DEFAULT_BUNDLE_FORMS ||= [:c100, :c1a, :c8].freeze

    attr_reader :c100_application

    # delegate :to_pdf, :has_forms_data?, to: :pdf_generator

    def initialize(c100_application)
      @c100_application = c100_application
    end

    def generate(*args)
      forms = args.presence || DEFAULT_BUNDLE_FORMS

      [{
        solicitor: [solicitor_json],
        header: {},
        id: @c100_application.id,
        children: children,
        applicants: applicants,
        respondents: respondents,
        typeOfApplication: type_of_application,
        hearingUrgency: hearing_urgency,
        miam: miam,
        allegationsOfHarm: allegation_of_harm,
        otherPeopleInTheCase: {},
        otherProceedings: other_proceedings,
        attendingTheHearing: attending_hearing,
        internationalElement: {},
        litigationCapacity: {},
        feeAmount: {},
        familyManNumber: {},
        others: {},
        events: {}
      }]
    end

    def filename
      'C100 child arrangements application.json'.freeze
    end

    private

    def solicitor_json
      solicitor = @c100_application.solicitor

      {name: solicitor.full_name,
       address: map_address_data(solicitor.address_data),
       contactDX: solicitor.dx_number,
       contactEmailAddress: solicitor.email,
       reference: solicitor.reference,
       ID: solicitor.id,
       organisationID: nil,
       organisationName: solicitor.firm_name}
    end

    def map_address_data(address_data)
      {
        County: nil,
        Country: address_data["country"],
        PostCode: address_data["postcode"],
        PostTown: address_data["town"],
        AddressLine1: address_data["address_line_1"],
        AddressLine2: address_data["address_line_2"],
        AddressLine3: address_data["address_line_3"]
      }
    end

    def children
      children_data = []
      @c100_application.children.each do |child|
        children_data << child_json(child)
      end
      children_data
    end

    def applicants
      applicants_data = []
      @c100_application.applicants.each do |applicant|
        applicants_data << applicant_json(applicant)
      end
      applicants_data
    end

    def respondents
      respondents_data = []
      @c100_application.respondents.each do |respondent|
        respondents_data << respondent_json(respondent)
      end
      respondents_data
    end

    def hearing_urgency
      {isCaseUrgent: @c100_application.urgent_hearing,
       setOutReasonsBelow: @c100_application.urgent_hearing_details,
       caseUrgencyTimeAndReason: @c100_application.urgent_hearing_when,
       # effortsMadeWithRespondents: nil,
       doYouNeedAWithoutNoticeHearing: @c100_application.without_notice,
       # areRespondentsAwareOfProceedings: "No",
       reasonsForApplicationWithoutNotice: @c100_application.without_notice_details,
       doYouRequireAHearingWithReducedNotice: @c100_application.urgent_hearing_short_notice}
    end

    def miam
    { applicantAttendedMiam: @c100_application.miam_attended,
      claimingExemptionMiam: @c100_application.miam_mediator_exemption,
      # familyMediatorMiam: nil,
      miamExemptionsChecklist: miam_list(:misc),
      miamDomesticViolenceChecklist:  miam_list(:domestic),
      miamUrgencyReasonChecklist: miam_list(:urgency),
      miamPreviousAttendanceChecklist: miam_list(:adr),
      # miamOtherGroundsChecklist: nil,
      mediatorRegistrationNumber: @c100_application.miam_certification_number,
      familyMediatorServiceName: @c100_application.miam_certification_service_name,
      soleTraderName: @c100_application.miam_certification_sole_trader_name,
      # mediatorRegistrationNumber1: nil,
      # familyMediatorServiceName1: nil,
      # soleTraderName1: nil
    }
    end


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
      allegationsOfHarmChildAbductionYesNo: @c100_application.risk_of_abduction,
      childAbductionReasons: abduction_details(:risk_details),
      previousAbductionThreats: abduction_details(:previous_attempt),
      previousAbductionThreatsDetails: abduction_details(:previous_attempt_details),
      agreeChildUnsupervisedTime: child_unsupervised,
      agreeChildSupervisedTime: child_supervised,
      agreeChildOtherContact: @c100_application.concerns_contact_other,
      childrenLocationNow: abduction_details(:current_location),
      abductionPassportOfficeNotified: abduction_details(:passport_office_notified),
      abductionChildHasPassport: abduction_details(:children_have_passport),
      abductionChildPassportPosession: abduction_details(:passport_possession),
      abductionChildPassportPosessionOtherDetail: abduction_details(:passport_possession_other_details),
      abductionPreviousPoliceInvolvement: abduction_details(:previous_attempt_agency_involved),
      abductionPreviousPoliceInvolvementDetails: abduction_details(:previous_attempt_agency_details),
      allegationsOfHarmSubstanceAbuseYesNo: @c100_application.substance_abuse,
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

    def other_proceedings
      {
        previousOrOngoingProceedingsForChildren: @c100_application.children_previous_proceedings,
        existingProceedings: existing_proceeding
      }
    end

    def attending_hearing
      {isWelshNeeded:  welsh_needed,
       welshNeeds: [welsh_details],
       isInterpreterNeeded: interpreter_needed,
       interpreterNeeds: interpreter_details,
       isSpecialArrangementsRequired: special_arrangements,
       specialArrangementsRequired: special_arrangements_details,
       isDisabilityPresent: disability_present,
       adjustmentsRequired: disability_requirements_details,
       isIntermediaryNeeded: intermediary_help
     }
    end

    private


    def intermediary_help
      arrangement = @c100_application.court_arrangement
      return 'No' if arrangement.blank?
      arrangement.intermediary_help

    end
    def special_arrangements
      arrangement = @c100_application.court_arrangement
      return 'No' if arrangement.blank?
      yes_no(!arrangement.special_arrangements.blank?)
    end

    def special_arrangements_details
      arrangement = @c100_application.court_arrangement
      return arrangement.special_arrangements_details if arrangement.special_arrangements.blank?
      list = arrangement.special_arrangements
      list << arrangement.special_arrangements_details.to_s
      list.join(', ')
    end

    def disability_present
      arrangement = @c100_application.court_arrangement
      return 'No' if arrangement.blank?
      yes_no(!arrangement.special_assistance.blank?)
    end

    def disability_requirements_details
      arrangement = @c100_application.court_arrangement
      return arrangement.special_assistance_details if arrangement.special_assistance.blank?
      list = arrangement.special_assistance
      list << arrangement.special_assistance_details.to_s
      list.join(', ')
    end

    def interpreter_needed
      arrangement = @c100_application.court_arrangement
      return 'No' if arrangement.blank?
      yes_no(arrangement.language_options.include?(LanguageHelp::LANGUAGE_INTERPRETER.to_s))
    end

    def interpreter_details
      arrangement = @c100_application.court_arrangement
      return arrangement.language_interpreter_details if arrangement.language_options.blank?
      return 'No' if arrangement.blank?
      list = arrangement.language_options
      list << arrangement.language_interpreter_details
      list.join(', ')
    end

    def welsh_needed
      arrangement = @c100_application.court_arrangement
      return 'No' if arrangement.blank?
      yes_no(arrangement.language_options.include?(LanguageHelp::WELSH_LANGUAGE.to_s))
    end
    def welsh_details
      arrangement = @c100_application.court_arrangement
      return 'No' if arrangement.blank?
      arrangement.welsh_language_details
    end

    def existing_proceeding
      return nil if @c100_application.court_proceeding.blank?
      @c100_application.court_proceeding.attributes.select {
        |key, value| key != 'id' && key != 'c100_application_id'
      }
    end

    def child_unsupervised
      return if @c100_application.concerns_contact_type.blank?
      unsupervised = ConcernsContactType.new(:unsupervised).value
      yes_no(@c100_application.concerns_contact_type == unsupervised.to_s)
    end

    def child_supervised
      return if @c100_application.concerns_contact_type.blank?
      supervised = ConcernsContactType.new(:supervised).value
      yes_no(@c100_application.concerns_contact_type == supervised.to_s)
    end

    def court_order(key)
      return if @c100_application.court_order.blank?
      @c100_application.court_order.send(key)
    end

    def abuse_concern(key)
      abuse = @c100_application.abuse_concerns.find_by(kind: key)
      abuse.answer if abuse.present?
    end

    def abduction_details(key)
      if @c100_application.abduction_detail
        return @c100_application.abduction_detail.send(key).join(', ') if key == :passport_possession
        return @c100_application.abduction_detail.send(key)
      end
    end

    def miam_list(key)
      if @c100_application.miam_exemption
        return @c100_application.miam_exemption.send(key).join(', ')
      end
    end

    def child_json(child)
      {
        firstName: child.first_name,
        lastName: child.last_name,
        dateOfBirth: child.dob.to_s(:db),
        gender: child.gender,
        childLiveWith: child.first_name,
        parentalResponsibilityDetails: child.parental_responsibility,
        # "orderAppliedFor"=>"Child Arrangements Order",
        # "applicantsRelationshipToChild"=>"Father",
        # "respondentsRelationshipToChild"=>"Guardian",
        # "otherApplicantsRelationshipToChild"=>nil,
        # "otherRespondentsRelationshipToChild"=>nil,
        # "personWhoLivesWithChild"=>[]
      }
    end

    def applicant_json(applicant)
      {
        firstName: applicant.first_name,
        lastName: applicant.last_name,
        previousName: applicant.previous_name,
        dateOfBirth: applicant.dob.to_s(:db),
        gender: applicant.gender,
        email: applicant.email,
        phoneNumber: applicant.mobile_phone,
        placeOfBirth: applicant.birthplace,
        address: map_address_data(applicant.address_data),
        isAtAddressLessThan5Years: "No",
        addressLivedLessThan5YearsDetails: nil,
        isAddressConfidential: yes_no(applicant.residence_keep_private),
        isPhoneNumberConfidential: yes_no(applicant.mobile_keep_private),
        isEmailAddressConfidential: yes_no(applicant.email_keep_private)
      }
    end

    def respondent_json(respondent)
      {
        firstName: respondent.first_name,
        lastName: respondent.last_name,
        previousName: respondent.previous_name,
        dateOfBirth: respondent_dob(respondent),
        isDateOfBirthKnown: yes_no(respondent.dob.present?),
        gender: respondent.gender,
        email: respondent.email,
        phoneNumber: respondent.mobile_phone,
        isPlaceOfBirthKnown: yes_no(respondent.birthplace.present?),
        placeOfBirth: respondent.birthplace,
        isCurrentAddressKnown: yes_no(respondent.address_data.present?),
        address: map_address_data(respondent.address_data),
        isAtAddressLessThan5Years: "No",
        addressLivedLessThan5YearsDetails: nil,
        isAddressConfidential: yes_no(respondent.residence_keep_private),
        canYouProvidePhoneNumber: yes_no(!respondent.mobile_keep_private),
        canYouProvideEmailAddress: yes_no(!respondent.email_keep_private)
      }
    end

    def type_of_application
      child = @c100_application.children
      {orderAppliedFor: order_type_answers(@c100_application.children),
       typeOfChildArrangementsOrder: order_arrangements,
       # natureOfOrder: "egb",
       consentOrder: @c100_application.consent_order,
       applicationPermissionRequired: @c100_application.permission_sought,
       applicationPermissionRequiredReason: @c100_application.permission_details,
       applicationDetails: @c100_application.application_details }
    end

    def yes_no(value)
      return 'No' if value == false
      'Yes' if value == true
    end

    def respondent_dob(respondent)
      dob = respondent.try(:dob)
      dob.to_s(:db) if dob
    end

    def order_type_answers(children)
      orders = []
      children.each do |child|
       orders << order_types(child).map{|order_value|
          I18n.t(".dictionary.PETITION_ORDER_TYPES.#{order_value}")
        }
      end
      orders.flatten.join(', ')
    end

    def order_arrangements
      orders = []
      @c100_application.orders.each do |order|
        orders << I18n.t(".dictionary.ARRANGEMENT_ORDERS.#{order}")
      end
      orders.flatten.join(', ')
    end

    def order_types(child)
      child.child_order&.orders.to_a.map do |o|
        PetitionOrder.type_for(o)
      end.uniq
    end

  end
end
