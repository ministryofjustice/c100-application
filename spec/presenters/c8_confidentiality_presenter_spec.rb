require 'spec_helper'

RSpec.describe C8ConfidentialityPresenter do
  let(:person) {
    instance_double(Applicant, full_address: 'real full address', residence_history: nil,
      contact_details_private: contact_details_private,
      email: 'mail', phone_number: '11335566', gender: 'male',
      c100_application: c100_application_one, refuge: GenericYesNo::NO.to_s
      )
  }
  let(:c100_application_one) { instance_double('C100Application', confidentiality_enabled?: true)}
  let(:c100_application_two) { instance_double('C100Application', confidentiality_enabled?: false)}
  
  let(:person_two) {
    instance_double(Applicant, full_address: 'real full address', residence_history: nil, 
      contact_details_private: [],
      email: 'mail', phone_number: '11335566', gender: 'male', c100_application: c100_application_two, refuge: GenericYesNo::NO.to_s)
  }

  let(:person_three) {
    instance_double(Applicant, full_address: 'real full address', residence_history: nil,
                    contact_details_private: [],
                    email: 'mail', phone_number: '11335566', gender: 'male', c100_application: c100_application_two, refuge: GenericYesNo::YES.to_s)
  }

  let(:contact_details_private) { [
    ContactDetails::ADDRESS.to_s,
    ContactDetails::EMAIL.to_s,
    ContactDetails::PHONE_NUMBER.to_s
  ] }
  
  subject { described_class.new(person) }

  describe '#to_ary' do
    it 'forwards private method' do
      x, y = subject
      expect(x).to eq(subject)
      expect(y).to be_nil
    end
  end

  describe '.replacement_answer' do
    it { expect(described_class.replacement_answer).to eq('[See C8]') }
  end

  it 'returns the original answer if it is blank/nil' do
    expect(subject.residence_history).to eq(nil)
  end

  it 'returns the replacement answer when confidentiality applies' do
    expect(subject.full_address).to eq('[See C8]')
  end

  context 'display value when not private' do
    let(:contact_details_private) { [] }
    it 'returns the replacement answer when residence is set to private' do
      expect(subject.full_address).not_to eq('[See C8]')
    end

    it 'returns the replacement answer when email is set to private' do
      expect(subject.email).not_to eq('[See C8]')
    end

    it 'returns the replacement answer when confidentiality applies' do
      expect(subject.phone_number).not_to eq('[See C8]')
    end
  end

  context 'no private attribute present' do
    subject { described_class.new(person_two) }

    it 'returns the real value for full_address' do
      expect(subject.full_address).not_to eq('[See C8]')
    end

    it 'returns the real value for email' do
      expect(subject.email).not_to eq('[See C8]')
    end

    it 'returns the real value for phone_number' do
      expect(subject.phone_number).not_to eq('[See C8]')
    end

    # it 'returns the replacement answer when confidentiality applies' do
    #   expect(subject.full_address).not_to eq('[See C8]')
    # end
    # it 'returns the replacement answer when confidentiality applies' do
    #   expect(subject.full_address).not_to eq('[See C8]')
    # end
  end

  context 'no private attribute present but with refuge' do
    subject { described_class.new(person_three) }

    it 'returns the real value for full_address' do
      expect(subject.full_address).to eq('[See C8]')
    end

    it 'returns the real value for email' do
      expect(subject.email).to eq('[See C8]')
    end

    it 'returns the real value for phone_number' do
      expect(subject.phone_number).to eq('[See C8]')
    end
  end

  it 'returns the original answer when confidentiality does not apply' do
    expect(subject.gender).to eq('male')
  end
end
