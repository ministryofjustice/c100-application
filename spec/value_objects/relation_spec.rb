require 'rails_helper'

RSpec.describe Relation do
  let(:value) { :foo }
  subject     { described_class.new(value) }

  describe '.values' do
    it 'returns all possible values' do
      expect(described_class.values.map(&:to_s)).to eq(%w(
        mother
        father
        legal_guardian
        grandparent
        relative
        family_friend
        social_worker
        other
      ))
    end
  end
end
