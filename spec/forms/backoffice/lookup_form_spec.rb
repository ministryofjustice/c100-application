require 'spec_helper'

RSpec.describe Backoffice::LookupForm do
  context 'reference code validation' do
    it 'when email present' do
      form = described_class.new(reference_code: '', email_address: 'test@hmcts.net')
      expect(form).to be_valid
    end

    it 'when email is not present' do
      form = described_class.new(reference_code: '', email_address: '')
      expect(form).not_to be_valid
    end

    it 'when reference is present' do
      form = described_class.new(reference_code: '2021/05/CD7A69BC', email_address: '')
      expect(form).to be_valid
    end
  end

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

    it "format valid" do
      form = described_class.new(reference_code: '2021/05/CD7A69BC')
      expect(form.valid?).to be true
    end
    it "format invalid" do
      form = described_class.new(reference_code: 'CD7A69BC')
      expect(form.valid?).to be false
    end
  end
end
