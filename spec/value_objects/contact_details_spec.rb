require 'rails_helper'

RSpec.describe ContactDetails do
  let(:value) { :foo }
  subject     { described_class.new(value) }

  describe '.values' do
    it 'returns all possible values' do
      expect(described_class.values.map(&:to_s)).to eq(%w(address email mobile home_phone))
    end
  end
end
