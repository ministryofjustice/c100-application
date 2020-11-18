require 'spec_helper'

RSpec.describe C8ConfidentialityPresenter do
  let(:person) {
    instance_double(Applicant, full_address: 'real full address', residence_history: nil, gender: 'male')
  }

  subject { described_class.new(person) }

  describe 'constants' do
    it {
      expect(
        described_class::DETAILS_UNDER_C8
      ).to contain_exactly(
        :full_address,
        :residence_history,
        :home_phone,
        :mobile_phone,
        :email,
      )
    }
  end

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

  it 'returns the original answer when confidentiality does not apply' do
    expect(subject.gender).to eq('male')
  end
end
