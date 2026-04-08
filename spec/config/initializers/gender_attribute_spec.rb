require 'rails_helper'

RSpec.describe GenderAttributeType do
  subject(:type) { described_class.new }

  describe '#cast' do
    subject(:casted_value) { type.cast(value) }

    context 'when value is nil' do
      let(:value) { nil }
      it { expect(casted_value).to be_nil }
    end

    context 'when value is a symbol' do
      let(:value) { :female }
      it { expect(casted_value).to eq(Gender::FEMALE) }
    end

    context 'when value is a string' do
      let(:value) { 'female' }
      it { expect(casted_value).to eq(Gender::FEMALE) }
    end

    context 'when value is already a value object' do
      let(:value) { Gender::FEMALE }
      it { expect(casted_value).to eq(Gender::FEMALE) }
    end
  end
end