require 'spec_helper'

RSpec.describe Steps::Applicant::PrivacyPreferencesForm do
  let(:arguments) { {
    c100_application: c100_application,
    record: applicant,
    are_contact_details_private: are_contact_details_private,
    contact_details_private: contact_details_private
  } }

  let(:c100_application) { instance_double(
    C100Application, applicants: applicants_collection) }
  let(:applicants_collection) { double('applicants_collection') }
  let(:applicant) { double('Applicant', id: 'ae4ed69e-bcb3-49cc-b19e-7287b1f2abe6') }
  let(:are_contact_details_private) { GenericYesNo::YES }
  let(:contact_details_private) { ['address', 'email'] }

  subject { described_class.new(arguments) }

  describe '#save' do
    context 'when no c100_application is associated with the form' do
      let(:c100_application) { nil }

      it 'raises an error' do
        expect { subject.save }.to raise_error(BaseForm::C100ApplicationNotFound)
      end
    end

    context 'without an overall contact details privacy preference' do
      let(:are_contact_details_private){ nil }
      it 'does not save' do
        expect(subject.save).to be(false)
      end
    end

    context 'when contact details privacy preference is yes' do
      let(:contact_details_private){ [] }
      it 'requires preferences to be specified' do
        expect(subject.save).to be(false)
      end
    end

    context 'when contact details privacy preference is no' do
      let(:are_contact_details_private){ GenericYesNo::NO }
      let(:contact_details_private){ [] }
      let(:expected_attributes) {
        {
          are_contact_details_private: GenericYesNo::NO,
          contact_details_private: []
        }
      }
      it 'does not require preferences to be specified' do
        expect(applicants_collection).to receive(:find_or_initialize_by).with(
          id: 'ae4ed69e-bcb3-49cc-b19e-7287b1f2abe6'
        ).and_return(applicant)

        expect(applicant).to receive(:update).with(
          expected_attributes
        ).and_return(true)

        expect(subject.save).to be(true)
      end
    end

    context 'for valid details' do

      let(:expected_attributes) {
        {
          are_contact_details_private: GenericYesNo::YES,
          contact_details_private: ['address', 'email']
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
