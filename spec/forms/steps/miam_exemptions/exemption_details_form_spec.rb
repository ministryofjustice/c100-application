require 'spec_helper'

RSpec.describe Steps::MiamExemptions::ExemptionDetailsForm do
  let(:arguments) { {
    c100_application: c100_application,
    exemption_details: exemption_details,
  } }

  let(:c100_application) { instance_double(C100Application) }
  let(:exemption_details) { "details" }

  subject { described_class.new(arguments) }

  describe '#save' do
    context 'when no c100_application is associated with the form' do
      let(:c100_application) { nil }

      it 'raises an error' do
        expect { subject.save }.to raise_error(BaseForm::C100ApplicationNotFound)
      end
    end

    context 'validations on field presence' do
      it {should validate_presence_of(:exemption_details)}
    end

    context 'when details are present' do
      it 'saves the record, with the details' do
        expect(c100_application).to receive(:update).with(
          {
            exemption_details: "details",
          }
        ).and_return(true)

        expect(subject.save).to be(true)
      end
    end

    context 'when exemption details is not present' do
      let(:exemption_details) { nil }

      it 'does not save the record, with the details' do
        expect(c100_application).not_to receive(:update)

        expect(subject.save).to be(false)
      end
    end
  end
end