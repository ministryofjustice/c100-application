require 'rails_helper'

RSpec.describe ApplicationPlatform do
  let(:value) { :foo }
  subject     { described_class.new(value) }

  describe '.values' do
    it 'returns all possible values' do
      expect(described_class.values.map(&:to_s)).to eq(%w(my_hmcts gov_uk))
    end
  end

  describe '#my_hmcts?' do
    describe 'when the value is `my_hmcts`' do
      let(:value) { :my_hmcts }

      it 'returns true' do
        expect(subject.my_hmcts?).to eq(true)
      end
    end

    describe 'when the value is `gov_uk`' do
      let(:value) { :gov_uk }

      it 'returns false' do
        expect(subject.my_hmcts?).to eq(false)
      end
    end
  end

  describe '#gov_uk?' do
    describe 'when the value is `my_hmcts`' do
      let(:value) { :my_hmcts }

      it 'returns false' do
        expect(subject.gov_uk?).to eq(false)
      end
    end

    describe 'when the value is `gov_uk`' do
      let(:value) { :gov_uk }

      it 'returns true' do
        expect(subject.gov_uk?).to eq(true)
      end
    end
  end
end
