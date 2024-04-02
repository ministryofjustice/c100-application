require 'rails_helper'

RSpec.describe MiscExemptions do
  let(:value) { :foo }
  subject     { described_class.new(value) }

  context 'WITHOUT_NOTICE' do
    it 'returns the expected values' do
      expect(described_class::WITHOUT_NOTICE.to_s).to eq('misc_without_notice')
    end
  end

  describe 'MIAM access exemptions' do
    context 'GROUP_MIAM_ACCESS' do
      it 'returns the expected values' do
        expect(described_class::GROUP_MIAM_ACCESS.to_s).to eq('group_miam_access')
      end
    end

    context 'MIAM_ACCESS' do
      it 'returns the expected values' do
        expect(described_class::MIAM_ACCESS.map(&:to_s)).to eq(%w(
          miam_access_disabled_facilities
          miam_access_appointment
          miam_access_mediator_nearby
        ))
      end
    end
  end

  context 'MISC_ACCESS' do
    it 'returns the expected values' do
      expect(described_class::MISC_ACCESS.to_s).to eq('misc_access')
      expect(described_class::MISC_ACCESS2.to_s).to eq('misc_access2')
      expect(described_class::MISC_ACCESS3.to_s).to eq('misc_access3')
      expect(described_class::MISC_ACCESS4.to_s).to eq('misc_access4')
    end
  end

  context 'MISC_NONE' do
    it 'returns the expected values' do
      expect(described_class::MISC_NONE.to_s).to eq('misc_none')
    end
  end
end
