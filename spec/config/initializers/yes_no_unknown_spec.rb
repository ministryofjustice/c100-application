require 'rails_helper'

RSpec.describe YesNoUnknownType do
  subject { described_class.new }

  let(:coerced_value) { subject.cast(value) }

  describe 'when value is `nil`' do
    let(:value) { nil }
    it { expect(coerced_value).to be_nil }
  end

  describe 'when value is a symbol' do
    let(:value) { :yes }
    it { expect(coerced_value).to eq(GenericYesNoUnknown::YES) }
  end

  describe 'when value is a string' do
    let(:value) { 'yes' }
    it { expect(coerced_value).to eq(GenericYesNoUnknown::YES) }
  end

  describe 'when value is already a value-object' do
    let(:value) { GenericYesNoUnknown::YES }
    it { expect(coerced_value).to eq(GenericYesNoUnknown::YES) }
  end
end