require 'spec_helper'

RSpec.describe Backoffice::LookupForm do
  context 'reference_code transformation' do
    it "strip spaces" do
      form = described_class.new(reference_code: ' ABC1 ')
      expect(form.reference_code).to eq('ABC1')
    end

    it "uppercase code" do
      form = described_class.new(reference_code: 'abc1-dEf3')
      expect(form.reference_code).to eq('ABC1-DEF3')
    end

    it "capitalize code" do
      expect do
        described_class.new(reference_code: nil)
      end.not_to raise_error
    end
  end
end
