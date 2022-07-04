RSpec.describe Presenters::Summary::JsonPresenter do
  subject(:subject) { described_class.new(c100_application) }
  let(:c100_application) { instance_double(C100Application, solicitor: solicitor,
    id: '17536fe9-53f1-4bc9-a839-54434f83202e',
    children: [child],
    applicants: [applicant],
    ) }

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

    let(:child) do
      instance_double(Child,
       first_name: "Joe",
       last_name: "Doe",
       gender: "female",
       dob: Date.parse('30 Nov 1989'),
       special_guardianship_order: "no",
       parental_responsibility: "Petr and Anna",
       )
    end

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
      it { expect(applicant_json[:isAtAddressLessThan5Years]).to eql 'No' }
      it { expect(applicant_json[:addressLivedLessThan5YearsDetails]).to eql nil }
      it { expect(applicant_json[:isAddressConfidential]).to eql 'Yes' }
      it { expect(applicant_json[:isPhoneNumberConfidential]).to eql nil }
      it { expect(applicant_json[:isEmailAddressConfidential]).to eql nil }
    end

  end

end
