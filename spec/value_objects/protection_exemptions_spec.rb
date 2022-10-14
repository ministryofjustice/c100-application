require 'rails_helper'

RSpec.describe ProtectionExemptions do
  let(:value) { :foo }
  subject     { described_class.new(value) }

  describe 'Authority involvement exemptions' do
    it 'returns the expected values' do
      expect(described_class::AUTHORITY_INVOLVEMENT.map(&:to_s)).to eq(%w(
        misc_authority_enquiring
        misc_authority_protection_order
      ))
    end
  end

  context 'PROTECTION_NONE' do
    it 'returns the expected values' do
      expect(described_class::PROTECTION_NONE.to_s).to eq('misc_protection_none')
    end
  end
end
