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
    urgent_hearing_short_notice: 'no'
    ) }

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
  end

end
