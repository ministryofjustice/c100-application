# rubocop:disable Metrics/BlockLength
RSpec.describe Summary::JsonPresenter do
  subject(:subject) { described_class.new(c100_application) }
  let(:c100_application) do
    C100Application.create(
      orders: orders,
      consent_order: 'yes',
      permission_sought: 'not required',
      permission_details: 'test',
      application_details: 'details',
      urgent_hearing: 'no',
      urgent_hearing_details: 'urgency reason',
      urgent_hearing_when: 'tomorrow',
      without_notice: 'yes',
      without_notice_details: 'why not',
      urgent_hearing_short_notice: 'no',
      miam_attended: 'no',
      miam_mediator_exemption: 'yes',
      risk_of_abduction: 'yes',
      substance_abuse: 'yes',
      concerns_contact_type: 'supervised',
      concerns_contact_other: 'no',
      children_previous_proceedings: 'yes',
      international_resident: 'yes resident',
      international_resident_details: 'resident',
      international_jurisdiction: 'yes jurisdiction',
      international_jurisdiction_details: 'jurisdiction',
      international_request: 'yes request',
      international_request_details: 'request',
      reduced_litigation_capacity: 'yes',
      participation_capacity_details: 'capacity',
      participation_other_factors_details: 'factors',
      participation_referral_or_assessment_details: 'referral'
    )
  end

  before do
    solicitor
    child1
    applicant
    respondent
    other_party
    miam_exemption
    abduction
    abuse_concerns
    court_order
    court_proceeding
    court_arrangement
    relationship_applicant
    relationship_respondent
    relationship_other
  end

  let(:orders) { [] }
  let(:solicitor) do
    Solicitor.create(
      full_name: 'Johny lawyer',
      address_data: address,
      dx_number: 'XSDFC1',
      email: 'john@court.com',
      reference: 'ref 123',
      id: '123',
      firm_name: 'Law and Order',
      c100_application: c100_application
    )
  end

  let(:address) do
    {
      "address_line_1" => 'house',
      "address_line_2" => 'street',
      "address_line_3" => 'block',
      "town" => 'Birmingham',
      "country" => 'United Kingdom',
      "postcode" => 'B54QO'
    }
  end

  let(:json_address) do
    {
      County: nil,
      Country: "United Kingdom",
      PostCode: "B54QO",
      PostTown: "Birmingham",
      AddressLine1: "house",
      AddressLine2: "street",
      AddressLine3: "block"
    }
  end

  describe '#generate' do
    let(:json_file) { subject.generate }

    context 'solicitor data' do
      let(:solicitor_json) { json_file[0][:solicitor][0] }

      it { expect(solicitor_json[:name]).to eql 'Johny lawyer' }
      it { expect(solicitor_json[:address]).to eq json_address }
      it { expect(solicitor_json[:contactDX]).to eql 'XSDFC1' }
      it { expect(solicitor_json[:contactEmailAddress]).to eql 'john@court.com' }
      it { expect(solicitor_json[:reference]).to eql 'ref 123' }
      it { expect(solicitor_json[:ID]).to eql solicitor.id }
      it { expect(solicitor_json[:organisationID]).to eql nil }
      it { expect(solicitor_json[:organisationName]).to eql 'Law and Order' }
    end

    it { expect(json_file[0][:id]).to eql c100_application.id }

    let(:child1) do
      Child.create(
        first_name: "Joe",
        last_name: "Doe",
        gender: "female",
        dob: Date.parse('30 Nov 1989'),
        special_guardianship_order: "no",
        parental_responsibility: "Petr and Anna",
        child_order: child_order,
        child_residence: child1_residence,
        c100_application: c100_application
      )
    end

    let(:relationship_applicant) do
      Relationship.create(
        relation: "Father",
        relation_other_value: nil,
        minor_id: child1.id,
        person_id: applicant.id,
        c100_application: c100_application,
      )
    end
    let(:relationship_respondent) do
      Relationship.create(
        relation: "Mother",
        relation_other_value: nil,
        minor_id: child1.id,
        person_id: respondent.id,
        c100_application: c100_application,
      )
    end
    let(:relationship_other) do
      Relationship.create(
        relation: "Guardian",
        relation_other_value: nil,
        minor_id: child1.id,
        person_id: other_party.id,
        c100_application: c100_application,
      )
    end

    let(:child1_residence) do
      ChildResidence.create(person_ids: [applicant.id])
    end

    let(:child_order) { ChildOrder.create(orders: %w[child_arrangements_home prohibited_steps_moving]) }

    context 'with error' do
      before do
        allow_any_instance_of(described_class).to receive(:create_hash).
          and_raise(StandardError)
      end

      it 'reports error to sentry' do
        expect(Sentry).to receive(:capture_exception)
        expect(subject.generate).to eq([{}])
      end

    end

    context 'children data' do
      let(:children_json) { json_file[0][:children][0] }

      it { expect(children_json[:firstName]).to eql 'Joe' }
      it { expect(children_json[:lastName]).to eql 'Doe' }
      it { expect(children_json[:dateOfBirth]).to eql '1989-11-30' }
      it { expect(children_json[:gender]).to eql 'female' }
      it { expect(children_json[:otherGender]).to eql nil }
      it { expect(children_json[:childLiveWith]).to eql ['Applicant'] }
      # it { expect(children_json[:orderAppliedFor]).to eql 'Child Arrangements Order' }
      it { expect(children_json[:applicantsRelationshipToChild]).to eql 'Father' }
      it { expect(children_json[:parentalResponsibilityDetails]).to eql 'Petr and Anna' }
      it { expect(children_json[:respondentsRelationshipToChild]).to eql 'Mother' }
      it { expect(children_json[:otherApplicantsRelationshipToChild]).to eql 'Guardian' }
      # it { expect(children_json[:otherRespondentsRelationshipToChild]).to eql 'child 1 other respondent' }
      # it { expect(children_json[:personWhoLivesWithChild]).to eq [] }
    end

    let(:applicant) do
      Applicant.create(
        first_name: "Kate",
        last_name: "Holmes",
        previous_name: "Dean",
        gender: "female",
        dob: Date.parse('30 Nov 1980'),
        birthplace: "cirencester",
        mobile_phone: "123456987",
        email: "kate@holmes.com",
        address_data: address,
        residence_requirement_met: "yes",
        residence_history: '',
        email_keep_private: nil,
        mobile_keep_private: nil,
        residence_keep_private: 'Yes',
        c100_application: c100_application
      )
    end

    let(:other_party) do
      OtherParty.create(
        first_name: "Grandma",
        last_name: "Nana",
        previous_name: "",
        gender: "female",
        dob: Date.parse('30 Nov 1940'),
        birthplace: "cirencester",
        mobile_phone: "123456987",
        email: "",
        address_data: address,
        residence_requirement_met: "yes",
        residence_history: '',
        email_keep_private: nil,
        mobile_keep_private: nil,
        residence_keep_private: 'Yes',
        c100_application: c100_application
      )
    end

    context 'applicant data' do
      let(:applicant_json) { json_file[0][:applicants][0] }
      let(:address) do
        {
          "address_line_1" => 'house 2',
          "address_line_2" => 'street 2',
          "address_line_3" => 'block 2',
          "town" => 'Birmingham 2',
          "country" => 'United Kingdom',
          "postcode" => 'BQODFD'
        }
      end

      it { expect(applicant_json[:firstName]).to eql 'Kate' }
      it { expect(applicant_json[:lastName]).to eql 'Holmes' }
      it { expect(applicant_json[:previousName]).to eql 'Dean' }
      it { expect(applicant_json[:dateOfBirth]).to eql '1980-11-30' }
      it { expect(applicant_json[:gender]).to eql 'female' }
      it { expect(applicant_json[:otherGender]).to eql nil }
      it { expect(applicant_json[:email]).to eql 'kate@holmes.com' }
      it { expect(applicant_json[:phoneNumber]).to eql '123456987' }
      it { expect(applicant_json[:placeOfBirth]).to eql 'cirencester' }
      it {
        expect(applicant_json[:address]).to eq({AddressLine1: "house 2", AddressLine2: "street 2", AddressLine3: "block 2",
       Country: "United Kingdom", County: nil, PostCode: "BQODFD", PostTown: "Birmingham 2"})
      }
      # it { expect(applicant_json[:isAtAddressLessThan5Years]).to eql 'No' }
      # it { expect(applicant_json[:addressLivedLessThan5YearsDetails]).to eql nil }
      it { expect(applicant_json[:isAddressConfidential]).to eql 'Yes' }
      it { expect(applicant_json[:isPhoneNumberConfidential]).to eql nil }
      it { expect(applicant_json[:isEmailAddressConfidential]).to eql nil }
    end

    let(:respondent) do
      Respondent.create(
        first_name: "Tom",
        last_name: "Jones",
        previous_name: "Sherlock",
        gender: "male",
        dob: nil,
        birthplace: nil,
        mobile_phone: "003456987",
        email: "tom@holmes.com",
        address_data: address,
        residence_requirement_met: "yes",
        residence_history: '',
        email_keep_private: true,
        mobile_keep_private: true,
        residence_keep_private: 'Yes',
        c100_application: c100_application
      )
    end

    context 'respondent data' do
      let(:respondent_json) { json_file[0][:respondents][0] }
      let(:address) { {} }

      it { expect(respondent_json[:firstName]).to eql 'Tom' }
      it { expect(respondent_json[:lastName]).to eql 'Jones' }
      it { expect(respondent_json[:previousName]).to eql 'Sherlock' }
      it { expect(respondent_json[:dateOfBirth]).to eql nil }
      it { expect(respondent_json[:isDateOfBirthKnown]).to eql 'No' }
      it { expect(respondent_json[:gender]).to eql 'male' }
      it { expect(respondent_json[:email]).to eql 'tom@holmes.com' }
      it { expect(respondent_json[:phoneNumber]).to eql '003456987' }
      it { expect(respondent_json[:isPlaceOfBirthKnown]).to eql 'No' }
      it { expect(respondent_json[:placeOfBirth]).to eql nil }
      it { expect(respondent_json[:isCurrentAddressKnown]).to eql 'No' }
      it {
        expect(respondent_json[:address]).to eq({AddressLine1: nil, AddressLine2: nil,
          AddressLine3: nil, PostTown: nil, County: nil,
          Country: nil, PostCode: nil})
      }
      # it { expect(respondent_json[:isAtAddressLessThan5Years]).to eql 'No' }
      # it { expect(respondent_json[:addressLivedLessThan5YearsDetails]).to eql nil }
      it { expect(respondent_json[:isAddressConfidential]).to eql 'Yes' }
      it { expect(respondent_json[:canYouProvidePhoneNumber]).to eql 'No' }
      it { expect(respondent_json[:canYouProvideEmailAddress]).to eql 'No' }
      # it { expect(respondent_json[:doTheyHaveLegalRepresentation]).to eql nil }
    end

    context 'type of application' do
      let(:type_of_application_json) { json_file[0][:typeOfApplication] }

      let(:orders) { %w[prohibited_steps_names child_arrangements_home group_prohibited_steps] }

      it { expect(type_of_application_json[:orderAppliedFor]).to eql 'Child Arrangements Order, Prohibited Steps Order' }
      it {
        text = 'Changing their names or surname, Decide who they live with and when, Stop the other person doing something'
        expect(type_of_application_json[:typeOfChildArrangementsOrder]).to eql text
      }
      # it { expect(type_of_application_json[:natureOfOrder]).to eql '' }
      it { expect(type_of_application_json[:consentOrder]).to eql 'yes' }
      it { expect(type_of_application_json[:applicationPermissionRequired]).to eql 'not required' }
      it { expect(type_of_application_json[:applicationPermissionRequiredReason]).to eql 'test' }
      it { expect(type_of_application_json[:applicationDetails]).to eql 'details' }
    end

    context 'hearing urgency' do
      let(:hearing_urgency_json) { json_file[0][:hearingUrgency] }
      let(:orders) { ['child_arrangements_home'] }

      it { expect(hearing_urgency_json[:isCaseUrgent]).to eql 'no' }
      it { expect(hearing_urgency_json[:setOutReasonsBelow]).to eql 'urgency reason' }
      it { expect(hearing_urgency_json[:caseUrgencyTimeAndReason]).to eql 'tomorrow' }
      # it { expect(hearing_urgency_json[:effortsMadeWithRespondents]).to eql 'yes' }
      it { expect(hearing_urgency_json[:doYouNeedAWithoutNoticeHearing]).to eql 'yes' }
      # it { expect(hearing_urgency_json[:areRespondentsAwareOfProceedings]).to eql 'test' }
      it { expect(hearing_urgency_json[:reasonsForApplicationWithoutNotice]).to eql 'why not' }
      it { expect(hearing_urgency_json[:doYouRequireAHearingWithReducedNotice]).to eql 'no' }
    end

    let(:miam_exemption) do
      MiamExemption.create(
        domestic: %w[police_arrested group_police],
        protection: ["protection_none"],
        urgency: %w[risk_applicant risk_unlawful_removal_retention],
        adr: ["existing_proceedings_attendance"],
        misc: %w[no_disabled_facilities no_respondent_address],
        c100_application: c100_application
      )
    end

    context 'miam' do
      let(:miam_json) { json_file[0][:miam] }
      let(:address) { {} }

      it { expect(miam_json[:applicantAttendedMiam]).to eql 'no' }
      it { expect(miam_json[:claimingExemptionMiam]).to eql 'yes' }
      # it { expect(miam_json[:familyMediatorMiam]).to eql 'no' }
      it { expect(miam_json[:miamExemptionsChecklist]).to eql "no_disabled_facilities, no_respondent_address" }
      it { expect(miam_json[:miamDomesticViolenceChecklist]).to eql "police_arrested, group_police" }
      it { expect(miam_json[:miamUrgencyReasonChecklist]).to eql "risk_applicant, risk_unlawful_removal_retention" }
      it { expect(miam_json[:miamPreviousAttendanceChecklist]).to eql "existing_proceedings_attendance" }
      # it { expect(miam_json[:miamOtherGroundsChecklist]).to eql nil }
    end

    let(:abduction) do
      AbductionDetail.create(
        children_have_passport: "yes",
        passport_office_notified: "yes",
        children_multiple_passports: "yes",
        passport_possession_other_details: 'other details',
        previous_attempt: "yes",
        previous_attempt_details: "tried to get them",
        previous_attempt_agency_involved: "yes",
        previous_attempt_agency_details: "told police before",
        risk_details: "something fishy",
        current_location: "by the sea",
        passport_possession: %w[mother father],
        c100_application: c100_application
      )
    end

    let(:abuse_concerns) do
      sexual_abuse
      physical_abuse
      financial_abuse
      psychological_abuse
      emotional_abuse
    end

    let(:sexual_abuse) do
      AbuseConcern.create(c100_application: c100_application,
                          subject: AbuseSubject::CHILDREN, kind: AbuseType::SEXUAL, answer: GenericYesNo::YES)
    end
    let(:physical_abuse) do
      AbuseConcern.create(c100_application: c100_application,
                          subject: AbuseSubject::CHILDREN, kind: AbuseType::PHYSICAL, answer: GenericYesNo::YES)
    end
    let(:financial_abuse) do
      AbuseConcern.create(c100_application: c100_application,
                          subject: AbuseSubject::CHILDREN, kind: AbuseType::FINANCIAL, answer: GenericYesNo::YES)
    end
    let(:psychological_abuse) do
      AbuseConcern.create(c100_application: c100_application,
                          subject: AbuseSubject::CHILDREN, kind: AbuseType::PSYCHOLOGICAL, answer: GenericYesNo::YES)
    end
    let(:emotional_abuse) do
      AbuseConcern.create(c100_application: c100_application,
                          subject: AbuseSubject::CHILDREN, kind: AbuseType::EMOTIONAL, answer: GenericYesNo::YES)
    end

    let(:court_order) do
      CourtOrder.create(c100_application: c100_application,
                        non_molestation: "yes",
                        non_molestation_issue_date: 3.days.ago.to_fs(:date),
                        non_molestation_length: "week",
                        non_molestation_is_current: "yes",
                        non_molestation_court_name: "bristol",
                        occupation: "yes",
                        occupation_issue_date: 2.days.ago.to_fs(:date),
                        occupation_length: "",
                        occupation_is_current: "current",
                        occupation_court_name: "court oc",
                        forced_marriage_protection: "nope",
                        forced_marriage_protection_issue_date: 4.days.ago.to_fs(:date),
                        forced_marriage_protection_length: "",
                        forced_marriage_protection_is_current: "forced current",
                        forced_marriage_protection_court_name: "court f",
                        restraining: "no",
                        restraining_issue_date: 4.days.ago.to_fs(:date),
                        restraining_length: "",
                        restraining_is_current: "yep",
                        restraining_court_name: "court rest",
                        injunctive: "yes in",
                        injunctive_issue_date: 5.days.ago.to_fs(:date),
                        injunctive_length: "",
                        injunctive_is_current: "still",
                        injunctive_court_name: "court inj",
                        undertaking: "no under",
                        undertaking_issue_date: 1.days.ago.to_fs(:date),
                        undertaking_length: "",
                        undertaking_is_current: "under still",
                        undertaking_court_name: "court under",
                        c100_application_id: "33a2e4a6-7c67-4fb2-b65a-6bbe651ebbc4",
                        non_molestation_case_number: "[FILTERED]",
                        occupation_case_number: "[FILTERED]",
                        forced_marriage_protection_case_number: "[FILTERED]",
                        restraining_case_number: "[FILTERED]",
                        injunctive_case_number: "[FILTERED]",
                        undertaking_case_number: "[FILTERED]")
    end
    context 'allegation_of_harm' do
      let(:allegation_of_harm_json) { json_file[0][:allegationsOfHarm] }
      let(:address) { {} }

      it { expect(allegation_of_harm_json[:allegationsOfHarmChildAbductionYesNo]).to eql 'yes' }
      it { expect(allegation_of_harm_json[:abductionChildHasPassport]).to eql 'yes' }
      it { expect(allegation_of_harm_json[:abductionPassportOfficeNotified]).to eql 'yes' }
      it { expect(allegation_of_harm_json[:abductionChildPassportPosessionOtherDetail]).to eql 'other details' }
      it { expect(allegation_of_harm_json[:previousAbductionThreats]).to eql 'yes' }
      it { expect(allegation_of_harm_json[:previousAbductionThreatsDetails]).to eql 'tried to get them' }
      it { expect(allegation_of_harm_json[:abductionPreviousPoliceInvolvement]).to eql 'yes' }
      it { expect(allegation_of_harm_json[:abductionPreviousPoliceInvolvementDetails]).to eql 'told police before' }
      it { expect(allegation_of_harm_json[:childAbductionReasons]).to eql 'something fishy' }
      it { expect(allegation_of_harm_json[:childrenLocationNow]).to eql 'by the sea' }
      it { expect(allegation_of_harm_json[:abductionChildPassportPosession]).to eq "mother, father" }

      it { expect(allegation_of_harm_json[:allegationsOfHarmSubstanceAbuseYesNo]).to eq "yes" }
      it { expect(allegation_of_harm_json[:sexualAbuseVictim].to_s).to eq "yes" }
      it { expect(allegation_of_harm_json[:physicalAbuseVictim].to_s).to eq "yes" }
      it { expect(allegation_of_harm_json[:financialAbuseVictim].to_s).to eq "yes" }
      it { expect(allegation_of_harm_json[:psychologicalAbuseVictim].to_s).to eq "yes" }
      it { expect(allegation_of_harm_json[:emotionalAbuseVictim].to_s).to eq "yes" }

      it { expect(allegation_of_harm_json[:ordersNonMolestation]).to eql 'yes' }
      it { expect(allegation_of_harm_json[:ordersNonMolestationDateIssued].to_s).to eql 3.days.ago.to_date.to_s }
      it { expect(allegation_of_harm_json[:ordersNonMolestationEndDate]).to eql nil }
      it { expect(allegation_of_harm_json[:ordersNonMolestationCurrent]).to eql 'yes' }
      it { expect(allegation_of_harm_json[:ordersNonMolestationCourtName]).to eql 'bristol' }

      it { expect(allegation_of_harm_json[:ordersOccupationDateIssued].to_s).to eql 2.days.ago.to_date.to_s }
      it { expect(allegation_of_harm_json[:ordersOccupationEndDate]).to eql nil }
      it { expect(allegation_of_harm_json[:ordersOccupation]).to eql 'yes' }
      it { expect(allegation_of_harm_json[:ordersOccupationCurrent]).to eql 'current' }
      it { expect(allegation_of_harm_json[:ordersOccupationCourtName]).to eql 'court oc' }

      it { expect(allegation_of_harm_json[:ordersForcedMarriageProtectionDateIssued].to_s).to eql 4.days.ago.to_date.to_s }
      it { expect(allegation_of_harm_json[:ordersForcedMarriageProtectionEndDate]).to eql nil }
      it { expect(allegation_of_harm_json[:ordersForcedMarriageProtection]).to eql 'nope' }
      it { expect(allegation_of_harm_json[:ordersForcedMarriageProtectionCurrent]).to eql 'forced current' }
      it { expect(allegation_of_harm_json[:ordersForcedMarriageProtectionCourtName]).to eql 'court f' }

      it { expect(allegation_of_harm_json[:ordersRestrainingDateIssued].to_s).to eql 4.days.ago.to_date.to_s }
      it { expect(allegation_of_harm_json[:ordersRestrainingEndDate]).to eql nil }
      it { expect(allegation_of_harm_json[:ordersRestrainingCourtName]).to eql 'court rest' }
      it { expect(allegation_of_harm_json[:ordersRestrainingCurrent]).to eql 'yep' }
      it { expect(allegation_of_harm_json[:ordersRestraining]).to eql 'no' }

      it { expect(allegation_of_harm_json[:ordersOtherInjunctiveDateIssued].to_s).to eql 5.days.ago.to_date.to_s }
      it { expect(allegation_of_harm_json[:ordersOtherInjunctiveEndDate]).to eql nil }
      it { expect(allegation_of_harm_json[:ordersOtherInjunctiveCourtName]).to eql 'court inj' }
      it { expect(allegation_of_harm_json[:ordersOtherInjunctiveCurrent]).to eql 'still' }
      it { expect(allegation_of_harm_json[:ordersOtherInjunctive]).to eql 'yes in' }

      it { expect(allegation_of_harm_json[:ordersUndertakingInPlaceDateIssued].to_s).to eql 1.days.ago.to_date.to_s }
      it { expect(allegation_of_harm_json[:ordersUndertakingInPlaceEndDate]).to eql nil }
      it { expect(allegation_of_harm_json[:ordersUndertakingInPlaceCourtName]).to eql 'court under' }
      it { expect(allegation_of_harm_json[:ordersUndertakingInPlaceCurrent]).to eql 'under still' }
      it { expect(allegation_of_harm_json[:ordersUndertakingInPlace]).to eql 'no under' }
      # it { expect(allegation_of_harm_json[:allegationsOfHarmOtherConcerns]).to eql nil }

      it { expect(allegation_of_harm_json[:agreeChildUnsupervisedTime]).to eql 'No' }
      it { expect(allegation_of_harm_json[:agreeChildSupervisedTime]).to eql 'Yes' }
      it { expect(allegation_of_harm_json[:agreeChildOtherContact]).to eql 'no' }
    end

    let(:court_proceeding) do
      CourtProceeding.create(
        "children_names" => "little jim",
        "court_name" => "court 1",
        "case_number" => "ABC456",
        "proceedings_date" => "2 2020",
        "cafcass_details" => "BGR586",
        "order_types" => "test",
        "previous_details" => "not sure",
        c100_application: c100_application
      )
    end

    let(:existing_processeding) do
      { "children_names" => "little jim",
         "court_name" => "court 1",
         "case_number" => "ABC456",
         "proceedings_date" => "2 2020",
         "cafcass_details" => "BGR586",
         "order_types" => "test",
         "previous_details" => "not sure"}
    end

    context 'otherProceedings' do
      let(:other_proceeding_json) { json_file[0][:otherProceedings] }
      it { expect(other_proceeding_json[:previousOrOngoingProceedingsForChildren]).to eql 'yes' }
      it { expect(other_proceeding_json[:existingProceedings]).to eq existing_processeding }
    end

    let(:court_arrangement) do
      CourtArrangement.create(
        c100_application: c100_application,
        intermediary_help: 'no',
        language_options: [LanguageHelp::WELSH_LANGUAGE.to_s,
                           LanguageHelp::LANGUAGE_INTERPRETER.to_s,
                           LanguageHelp::SIGN_LANGUAGE_INTERPRETER.to_s],
        welsh_language_details: 'welsh details',
        language_interpreter_details: 'interpreter details',
        special_arrangements: ['separate_waiting_rooms'],
        special_arrangements_details: 'test',
        special_assistance: %w[hearing_loop braille_documents],
        special_assistance_details: 'test assistance'
      )
    end

    context 'attending_hearing' do
      let(:attending_hearing_json) { json_file[0][:attendingTheHearing] }

      it { expect(attending_hearing_json[:isWelshNeeded]).to eql 'Yes' }
      it { expect(attending_hearing_json[:welshNeeds]).to eql ['welsh details'] }
      it { expect(attending_hearing_json[:isInterpreterNeeded]).to eql 'Yes' }
      it {
        list = 'welsh_language, language_interpreter, sign_language_interpreter, interpreter details'
        expect(attending_hearing_json[:interpreterNeeds]).to eql list
      }
      it { expect(attending_hearing_json[:isDisabilityPresent]).to eql 'Yes' }
      it { expect(attending_hearing_json[:adjustmentsRequired]).to eql 'hearing_loop, braille_documents, test assistance' }
      it { expect(attending_hearing_json[:isSpecialArrangementsRequired]).to eql 'Yes' }
      it { expect(attending_hearing_json[:specialArrangementsRequired]).to eql "separate_waiting_rooms, test" }
      it { expect(attending_hearing_json[:isIntermediaryNeeded]).to eql 'no' }
    end

    context 'international_element' do
      let(:international_element_json) { json_file[0][:internationalElement] }

      it { expect(international_element_json[:habitualResidentInOtherState]).to eql 'yes resident' }
      it { expect(international_element_json[:habitualResidentInOtherStateGiveReason]).to eql 'resident' }
      it { expect(international_element_json[:requestToForeignAuthority]).to eql 'yes request' }
      it { expect(international_element_json[:requestToForeignAuthorityGiveReason]).to eql 'request' }
      it { expect(international_element_json[:jurisdictionIssue]).to eql 'yes jurisdiction' }
      it { expect(international_element_json[:jurisdictionIssueGiveReason]).to eql 'jurisdiction' }
    end

    context 'litigation_capacity' do
      let(:litigation_capacity_json) { json_file[0][:litigationCapacity] }

      it { expect(litigation_capacity_json[:litigationCapacityFactors]).to eql 'yes' }
      it { expect(litigation_capacity_json[:litigationCapacityReferrals]).to eql 'capacity' }
      it { expect(litigation_capacity_json[:litigationCapacityOtherFactors]).to eql 'factors' }
      it { expect(litigation_capacity_json[:litigationCapacityOtherFactorsDetails]).to eql 'referral' }
    end

    context 'fee' do
      it { expect(json_file[0][:feeAmount]).to eql '£232.00' }
    end

    describe '#filename' do
      it 'returns filename' do
        expect(subject.filename).to eq('C100 child arrangements application.json')
      end
    end

    describe '#json_file' do
      it 'returns json version of c100_hash' do
        subject.generate
        expect(JSON.parse(subject.json_file.read)[0].keys).to eq(
          ["solicitor",
          "header",
           "id",
           "children",
           "applicants",
           "respondents",
           "typeOfApplication",
           "hearingUrgency",
           "miam",
           "allegationsOfHarm",
           "otherPeopleInTheCase",
           "otherProceedings",
           "attendingTheHearing",
           "internationalElement",
           "litigationCapacity",
           "feeAmount"])
      end
    end
  end


end
# rubocop:enable Metrics/BlockLength
