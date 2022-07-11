RSpec.describe Presenters::Summary::JsonPresenter do
  subject(:subject) { described_class.new(c100_application) }
  let(:c100_application) { instance_double(C100Application, solicitor: solicitor,
    id: '17536fe9-53f1-4bc9-a839-54434f83202e',
    children: children,
    applicants: [applicant],
    respondents: [respondent],
    orders: orders,
    consent_order: 'yes',
    permission_sought: 'not required',
    permission_details: 'test',
    application_details: 'details',
    urgent_hearing: 'no',
    urgent_hearing_details:'urgency reason',
    urgent_hearing_when: 'tomorrow',
    without_notice: 'yes',
    without_notice_details: 'why not',
    urgent_hearing_short_notice: 'no',
    miam_attended: 'no',
    miam_exemption: miam_exemption,
    miam_certification_number: '132',
    miam_mediator_exemption: 'yes',
    miam_certification_sole_trader_name: 'jim',
    miam_certification_service_name: 'miam service',
    abduction_detail: abduction,
    risk_of_abduction: 'yes',
    substance_abuse: 'yes',
    abuse_concerns: abuse_concerns,
    court_order: court_order,
    concerns_contact_type: 'supervised',
    concerns_contact_other: 'no',
    children_previous_proceedings: 'yes',
    court_proceeding: court_proceeding

    ) }
  before {
    allow(abuse_concerns).to receive(:find_by).with({:kind=>"sexual"}).and_return sexual_abuse
    allow(abuse_concerns).to receive(:find_by).with({:kind=>"physical"}).and_return physical_abuse
    allow(abuse_concerns).to receive(:find_by).with({:kind=>"financial"}).and_return financial_abuse
    allow(abuse_concerns).to receive(:find_by).with({:kind=>"psychological"}).and_return psychological_abuse
    allow(abuse_concerns).to receive(:find_by).with({:kind=>"emotional"}).and_return emotional_abuse
  }
  let(:children) { [child1] }
  let(:orders) { [] }
  let(:solicitor) do
    instance_double(Solicitor, address_data: address,
    full_name: 'Johny lawyer',
    dx_number: 'XSDFC1',
    email: 'john@court.com',
    reference: 'ref 123',
    id: '123',
    firm_name: 'Law and Order')
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
      it { expect(solicitor_json[:ID]).to eql '123' }
      it { expect(solicitor_json[:organisationID]).to eql nil }
      it { expect(solicitor_json[:organisationName]).to eql 'Law and Order' }
    end

    # HEADER - PDF says - to be completed by the court
    #   {"caseNumber"=>1649853803231585, "courtCode"=>nil, "courtName"=>nil, "caseType"=>"CHILD ARRANGEMENT CASE"}


    it { expect(json_file[0][:id]).to eql '17536fe9-53f1-4bc9-a839-54434f83202e' }


    let(:child1) do
      instance_double(Child,
       first_name: "Joe",
       last_name: "Doe",
       gender: "female",
       dob: Date.parse('30 Nov 1989'),
       special_guardianship_order: "no",
       parental_responsibility: "Petr and Anna",
       child_order: child_order
       )
    end
    let(:child_order) { instance_double(ChildOrder, orders: ['child_arrangements_home']) }

    context 'children data' do
      let(:children_json) { json_file[0][:children][0] }

      it { expect(children_json[:firstName]).to eql 'Joe' }
      it { expect(children_json[:lastName]).to eql 'Doe' }
      it { expect(children_json[:dateOfBirth]).to eql '1989-11-30' }
      it { expect(children_json[:gender]).to eql 'female' }
      it { expect(children_json[:otherGender]).to eql nil }
      # it { expect(children_json[:childLiveWith]).to eql 'Applicant' }
      # it { expect(children_json[:orderAppliedFor]).to eql 'Child Arrangements Order' }
      # it { expect(children_json[:applicantsRelationshipToChild]).to eql 'Father' }
      it { expect(children_json[:parentalResponsibilityDetails]).to eql 'Petr and Anna' }
      # it { expect(children_json[:respondentsRelationshipToChild]).to eql 'Guardian' }
      # it { expect(children_json[:otherApplicantsRelationshipToChild]).to eql 'child 1 other applicant' }
      # it { expect(children_json[:otherRespondentsRelationshipToChild]).to eql 'child 1 other respondent' }
      # it { expect(children_json[:personWhoLivesWithChild]).to eq [] }
    end

    let(:applicant) do
      instance_double(Applicant,
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
       residence_keep_private: true
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
      it { expect(applicant_json[:address]).to eq ({:AddressLine1=>"house 2", :AddressLine2=>"street 2", :AddressLine3=>"block 2", :Country=>"United Kingdom", :County=>nil, :PostCode=>"BQODFD", :PostTown=>"Birmingham 2"})}
      # it { expect(applicant_json[:isAtAddressLessThan5Years]).to eql 'No' }
      # it { expect(applicant_json[:addressLivedLessThan5YearsDetails]).to eql nil }
      it { expect(applicant_json[:isAddressConfidential]).to eql 'Yes' }
      it { expect(applicant_json[:isPhoneNumberConfidential]).to eql nil }
      it { expect(applicant_json[:isEmailAddressConfidential]).to eql nil }
    end

    let(:respondent) do
      instance_double(Applicant,
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
       residence_keep_private: true
       )
    end

    context 'respondent data' do
      let(:respondent_json) { json_file[0][:respondents][0] }
      let(:address) {{}}


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
      it { expect(respondent_json[:address]).to eq ({AddressLine1: nil, AddressLine2: nil, AddressLine3: nil, PostTown: nil, County: nil, Country: nil, PostCode: nil})}
      # it { expect(respondent_json[:isAtAddressLessThan5Years]).to eql 'No' }
      # it { expect(respondent_json[:addressLivedLessThan5YearsDetails]).to eql nil }
      it { expect(respondent_json[:isAddressConfidential]).to eql 'Yes' }
      it { expect(respondent_json[:canYouProvidePhoneNumber]).to eql 'No' }
      it { expect(respondent_json[:canYouProvideEmailAddress]).to eql 'No' }
      # it { expect(respondent_json[:doTheyHaveLegalRepresentation]).to eql nil }
    end

    context 'type of application' do
      let(:type_of_application_json) { json_file[0][:typeOfApplication] }
      let(:address) {{}}
      let(:children) { [child1, child2] }
      let(:child2) do
        instance_double(Child,
         first_name: "Joe",
         last_name: "Doe",
         gender: "female",
         dob: Date.parse('30 Nov 1989'),
         special_guardianship_order: "no",
         parental_responsibility: "Petr and Anna",
         child_order: child_order2
         )
      end
      let(:child_order2) { instance_double(ChildOrder, orders: ['prohibited_steps_moving']) }
      let(:orders) { ['child_arrangements_home'] }


      it { expect(type_of_application_json[:orderAppliedFor]).to eql 'Child Arrangements Order, Prohibited Steps Order' }
      it { expect(type_of_application_json[:typeOfChildArrangementsOrder]).to eql 'Decide who they live with and when' }
      # it { expect(type_of_application_json[:natureOfOrder]).to eql '' }
      it { expect(type_of_application_json[:consentOrder]).to eql 'yes' }
      it { expect(type_of_application_json[:applicationPermissionRequired]).to eql 'not required' }
      it { expect(type_of_application_json[:applicationPermissionRequiredReason]).to eql 'test' }
      it { expect(type_of_application_json[:applicationDetails]).to eql 'details' }
    end

    context 'hearing urgency' do
      let(:hearing_urgency_json) { json_file[0][:hearingUrgency] }
      let(:address) {{}}
      let(:child_order2) { instance_double(ChildOrder, orders: ['prohibited_steps_moving']) }
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

    let(:miam_exemption) { instance_double(MiamExemption,
      domestic: ["police_arrested", "group_police"],
      protection: ["protection_none"],
      urgency: ["risk_applicant", "risk_unlawful_removal_retention"],
      adr: ["existing_proceedings_attendance"],
      misc: ["no_disabled_facilities", "no_respondent_address"]) }

    context 'miam' do
      let(:miam_json) { json_file[0][:miam] }
      let(:address) {{}}


      it { expect(miam_json[:applicantAttendedMiam]).to eql 'no' }
      it { expect(miam_json[:claimingExemptionMiam]).to eql 'yes' }
      # it { expect(miam_json[:familyMediatorMiam]).to eql 'no' }
      it { expect(miam_json[:miamExemptionsChecklist]).to eql "no_disabled_facilities, no_respondent_address" }
      it { expect(miam_json[:miamDomesticViolenceChecklist]).to eql "police_arrested, group_police" }
      it { expect(miam_json[:miamUrgencyReasonChecklist]).to eql "risk_applicant, risk_unlawful_removal_retention" }
      it { expect(miam_json[:miamPreviousAttendanceChecklist]).to eql "existing_proceedings_attendance" }
      # it { expect(miam_json[:miamOtherGroundsChecklist]).to eql nil }
      it { expect(miam_json[:mediatorRegistrationNumber]).to eql '132' }
      it { expect(miam_json[:familyMediatorServiceName]).to eql 'miam service' }
      it { expect(miam_json[:soleTraderName]).to eql 'jim' }

    end

    let(:abduction) { instance_double(AbductionDetail,
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
       passport_possession: ["mother", "father"] )
    }

    let(:abuse_concerns) {
      class_double(AbuseConcern)
    }


    let(:sexual_abuse) { instance_double(AbuseConcern,
      subject: "children", kind: "sexual", answer: "yes sexual")
    }
    let(:physical_abuse) { instance_double(AbuseConcern,
      subject: "children", kind: "physical", answer: "yes physical")
    }
    let(:financial_abuse) { instance_double(AbuseConcern,
      subject: "children", kind: "financial", answer: "yes financial")
    }
    let(:psychological_abuse) { instance_double(AbuseConcern,
      subject: "children", kind: "psychological", answer: "yes psychological")
    }
    let(:emotional_abuse) { instance_double(AbuseConcern,
      subject: "children", kind: "emotional", answer: "yes emotional")
    }


    let(:court_order) {
      instance_double(CourtOrder,
        non_molestation: "yes",
        non_molestation_issue_date: 3.days.ago.to_s(:date),
        non_molestation_length: "week",
        non_molestation_is_current: "yes",
        non_molestation_court_name: "bristol",
        occupation: "yes",
        occupation_issue_date: 2.days.ago.to_s(:date),
        occupation_length: "",
        occupation_is_current: "current",
        occupation_court_name: "court oc",
        forced_marriage_protection: "nope",
        forced_marriage_protection_issue_date: 4.days.ago.to_s(:date),
        forced_marriage_protection_length: "",
        forced_marriage_protection_is_current: "forced current",
        forced_marriage_protection_court_name: "court f",
        restraining: "no",
        restraining_issue_date: 4.days.ago.to_s(:date),
        restraining_length: "",
        restraining_is_current: "yep",
        restraining_court_name: "court rest",
        injunctive: "yes in",
        injunctive_issue_date: 5.days.ago.to_s(:date),
        injunctive_length: "",
        injunctive_is_current: "still",
        injunctive_court_name: "court inj",
        undertaking: "no under",
        undertaking_issue_date: 1.days.ago.to_s(:date),
        undertaking_length: "",
        undertaking_is_current: "under still",
        undertaking_court_name: "court under",
        c100_application_id: "33a2e4a6-7c67-4fb2-b65a-6bbe651ebbc4",
        non_molestation_case_number: "[FILTERED]",
        occupation_case_number: "[FILTERED]",
        forced_marriage_protection_case_number: "[FILTERED]",
        restraining_case_number: "[FILTERED]",
        injunctive_case_number: "[FILTERED]",
        undertaking_case_number: "[FILTERED]"
      )
    }
    context 'allegation_of_harm' do
      let(:allegation_of_harm_json) { json_file[0][:allegationsOfHarm] }
      let(:address) {{}}


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
      it { expect(allegation_of_harm_json[:sexualAbuseVictim]).to eq "yes sexual" }
      it { expect(allegation_of_harm_json[:physicalAbuseVictim]).to eq "yes physical" }
      it { expect(allegation_of_harm_json[:financialAbuseVictim]).to eq "yes financial" }
      it { expect(allegation_of_harm_json[:psychologicalAbuseVictim]).to eq "yes psychological" }
      it { expect(allegation_of_harm_json[:emotionalAbuseVictim]).to eq "yes emotional" }

      it { expect(allegation_of_harm_json[:ordersNonMolestation]).to eql 'yes' }
      it { expect(allegation_of_harm_json[:ordersNonMolestationDateIssued]).to eql 3.days.ago.to_s(:date) }
      it { expect(allegation_of_harm_json[:ordersNonMolestationEndDate]).to eql nil }
      it { expect(allegation_of_harm_json[:ordersNonMolestationCurrent]).to eql 'yes' }
      it { expect(allegation_of_harm_json[:ordersNonMolestationCourtName]).to eql 'bristol' }

      it { expect(allegation_of_harm_json[:ordersOccupationDateIssued]).to eql 2.days.ago.to_s(:date) }
      it { expect(allegation_of_harm_json[:ordersOccupationEndDate]).to eql nil }
      it { expect(allegation_of_harm_json[:ordersOccupation]).to eql 'yes' }
      it { expect(allegation_of_harm_json[:ordersOccupationCurrent]).to eql 'current' }
      it { expect(allegation_of_harm_json[:ordersOccupationCourtName]).to eql 'court oc' }

      it { expect(allegation_of_harm_json[:ordersForcedMarriageProtectionDateIssued]).to eql 4.days.ago.to_s(:date) }
      it { expect(allegation_of_harm_json[:ordersForcedMarriageProtectionEndDate]).to eql nil }
      it { expect(allegation_of_harm_json[:ordersForcedMarriageProtection]).to eql 'nope' }
      it { expect(allegation_of_harm_json[:ordersForcedMarriageProtectionCurrent]).to eql 'forced current' }
      it { expect(allegation_of_harm_json[:ordersForcedMarriageProtectionCourtName]).to eql 'court f' }

      it { expect(allegation_of_harm_json[:ordersRestrainingDateIssued]).to eql 4.days.ago.to_s(:date) }
      it { expect(allegation_of_harm_json[:ordersRestrainingEndDate]).to eql nil }
      it { expect(allegation_of_harm_json[:ordersRestrainingCourtName]).to eql 'court rest' }
      it { expect(allegation_of_harm_json[:ordersRestrainingCurrent]).to eql 'yep' }
      it { expect(allegation_of_harm_json[:ordersRestraining]).to eql 'no' }

      it { expect(allegation_of_harm_json[:ordersOtherInjunctiveDateIssued]).to eql 5.days.ago.to_s(:date) }
      it { expect(allegation_of_harm_json[:ordersOtherInjunctiveEndDate]).to eql nil }
      it { expect(allegation_of_harm_json[:ordersOtherInjunctiveCourtName]).to eql 'court inj' }
      it { expect(allegation_of_harm_json[:ordersOtherInjunctiveCurrent]).to eql 'still' }
      it { expect(allegation_of_harm_json[:ordersOtherInjunctive]).to eql 'yes in' }

      it { expect(allegation_of_harm_json[:ordersUndertakingInPlaceDateIssued]).to eql 1.days.ago.to_s(:date) }
      it { expect(allegation_of_harm_json[:ordersUndertakingInPlaceEndDate]).to eql nil }
      it { expect(allegation_of_harm_json[:ordersUndertakingInPlaceCourtName]).to eql 'court under' }
      it { expect(allegation_of_harm_json[:ordersUndertakingInPlaceCurrent]).to eql 'under still' }
      it { expect(allegation_of_harm_json[:ordersUndertakingInPlace]).to eql 'no under' }
      # it { expect(allegation_of_harm_json[:allegationsOfHarmOtherConcerns]).to eql nil }

      it { expect(allegation_of_harm_json[:agreeChildUnsupervisedTime]).to eql 'No' }
      it { expect(allegation_of_harm_json[:agreeChildSupervisedTime]).to eql 'Yes' }
      it { expect(allegation_of_harm_json[:agreeChildOtherContact]).to eql 'no' }
    end

    let(:court_proceeding) {
      instance_double(CourtProceeding, attributes: existing_processeding_hash)
    }

    let(:existing_processeding) {
      { "children_ames"=>"little jim",
         "court_name"=>"court 1",
         "case_number"=>"ABC456",
         "proceedings_date"=>"2 2020",
         "cafcass_details"=>"BGR586",
         "order_types"=>"test",
         "previous_details"=>"not sure"}
    }

    let(:existing_processeding_hash) {
      { "id" => 123,
        "c100_application_id" => 345,
        "children_ames"=>"little jim",
         "court_name"=>"court 1",
         "case_number"=>"ABC456",
         "proceedings_date"=>"2 2020",
         "cafcass_details"=>"BGR586",
         "order_types"=>"test",
         "previous_details"=>"not sure"}
    }
    context 'otherProceedings' do
      let(:other_proceeding_json) { json_file[0][:otherProceedings] }
      it { expect(other_proceeding_json[:previousOrOngoingProceedingsForChildren]).to eql 'yes' }
      it { expect(other_proceeding_json[:existingProceedings]).to eq existing_processeding }

    end
  end

end
