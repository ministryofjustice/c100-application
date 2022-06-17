require 'spec_helper'

RSpec.describe Steps::Applicant::PrivacyKnownForm, focus: true do
  let(:arguments) { {
    c100_application: c100_application,
    record: applicant,
    privacy_known: privacy_known
  } }

  let(:c100_application) { instance_double(
    C100Application, applicants: applicants_collection) }
  let(:applicants_collection) { double('applicants_collection') }
  let(:applicant) { double('Applicant', id: 'ae4ed69e-bcb3-49cc-b19e-7287b1f2abe6') }
  let(:privacy_known) { GenericYesNoUnknown::YES }

  subject { described_class.new(arguments) }

  describe '#save' do
    context 'when no c100_application is associated with the form' do
      let(:c100_application) { nil }

      it 'raises an error' do
        expect { subject.save }.to raise_error(BaseForm::C100ApplicationNotFound)
      end
    end

    context 'without an overall contact details privacy preference' do
      let(:privacy_known){ nil }
      it 'does not save' do
        expect(subject.save).to be(false)
      end
    end

    context 'for valid details' do

      let(:expected_attributes) {
        {
          privacy_known: GenericYesNoUnknown::YES
        }
      }

      it 'saves' do
        expect(applicants_collection).to receive(:find_or_initialize_by).with(
          id: 'ae4ed69e-bcb3-49cc-b19e-7287b1f2abe6'
        ).and_return(applicant)
    
        expect(applicant).to receive(:update).with(
          expected_attributes
        ).and_return(true)

        expect(subject.save).to be(true)
      end
    end
  end
end
