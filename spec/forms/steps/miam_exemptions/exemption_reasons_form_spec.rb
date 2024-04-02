require 'spec_helper'

RSpec.describe Steps::MiamExemptions::ExemptionReasonsForm do
  let(:arguments) { {
    c100_application: c100_application,
    exemption_reasons: exemption_reasons,
    attach_evidence: attach_evidence
  } }

  let(:c100_application) { instance_double(C100Application) }
  let(:exemption_reasons) { "reasons" }
  let(:attach_evidence) { GenericYesNo.new('yes') }

  subject { described_class.new(arguments) }

  describe '#save' do
    context 'when no c100_application is associated with the form' do
      let(:c100_application) { nil }

      it 'raises an error' do
        expect { subject.save }.to raise_error(BaseForm::C100ApplicationNotFound)
      end
    end

    context 'validations on field presence' do
      it {should validate_presence_of(:attach_evidence, :inclusion)}
    end

    context 'when reasons and evidence are present' do
      it 'saves the record, with the details' do
        expect(c100_application).to receive(:update).with(
          {
            exemption_reasons: "reasons",
            attach_evidence: GenericYesNo::YES,
          }
        ).and_return(true)

        expect(subject.save).to be(true)
      end
    end

    context 'when reasons is not present' do
      let(:exemption_reasons) { nil }

      it 'saves the record, with the details' do
        expect(c100_application).to receive(:update).with(
          {
            exemption_reasons: nil,
            attach_evidence: GenericYesNo::YES,
          }
        ).and_return(true)

        expect(subject.save).to be(true)
      end
    end

    context 'when attach_evidence is not present' do
      let(:attach_evidence) { nil }

      it 'does not save the record, with the details' do
        expect(c100_application).not_to receive(:update)

        expect(subject.save).to be(false)
      end
    end
  end
end