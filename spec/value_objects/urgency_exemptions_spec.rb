require 'rails_helper'

RSpec.describe UrgencyExemptions do
  let(:value) { :foo }
  subject     { described_class.new(value) }

  context 'RISK_APPLICANT' do
    it 'returns the expected values' do
      expect(described_class::RISK_APPLICANT.to_s).to eq('misc_risk_applicant')
    end
  end

  context 'UNREASONABLE_HARDSHIP' do
    it 'returns the expected values' do
      expect(described_class::UNREASONABLE_HARDSHIP.to_s).to eq('misc_unreasonable_hardship')
    end
  end

  context 'RISK_CHILDREN' do
    it 'returns the expected values' do
      expect(described_class::RISK_CHILDREN.to_s).to eq('misc_risk_children')
    end
  end

  context 'RISK_UNLAWFUL_REMOVAL_RETENTION' do
    it 'returns the expected values' do
      expect(described_class::RISK_UNLAWFUL_REMOVAL_RETENTION.to_s).to eq('misc_risk_unlawful_removal_retention')
    end
  end

  context 'MISCARRIAGE_JUSTICE' do
    it 'returns the expected values' do
      expect(described_class::MISCARRIAGE_JUSTICE.to_s).to eq('misc_miscarriage_justice')
    end
  end

  context 'IRRETRIEVABLE_PROBLEMS' do
    it 'returns the expected values' do
      expect(described_class::IRRETRIEVABLE_PROBLEMS.to_s).to eq('misc_irretrievable_problems')
    end
  end

  context 'INTERNATIONAL_PROCEEDINGS' do
    it 'returns the expected values' do
      expect(described_class::INTERNATIONAL_PROCEEDINGS.to_s).to eq('misc_international_proceedings')
    end
  end

  context 'URGENCY_NONE' do
    it 'returns the expected values' do
      expect(described_class::URGENCY_NONE.to_s).to eq('misc_urgency_none')
    end
  end
end
