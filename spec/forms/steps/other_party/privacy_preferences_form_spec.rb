require 'spec_helper'

RSpec.describe Steps::OtherParty::PrivacyPreferencesForm do
  let(:arguments) do
    {
      c100_application: c100_application,
      record: record,
      privacy_known: privacy_known,
      are_contact_details_private: are_contact_details_private
    }
  end

  let(:c100_application) { instance_double(C100Application, other_parties: other_parties_collection) }
  let(:other_parties_collection) { double('other_parties_collection') }
  let(:party) { double('Party', id: 'ae4ed69e-bcb3-49cc-b19e-7287b1f2abe6') }

  let(:record) { nil }

  let(:privacy_known) { nil }
  let(:are_contact_details_private) { 'no' }

  subject { described_class.new(arguments) }

  before do
    allow(party).to receive(:person).and_return(party)
  end

  describe '#save' do
    context 'when no c100_application is associated with the form' do
      let(:c100_application) { nil }

      it 'raises an error' do
        expect { subject.save }.to raise_error(BaseForm::C100ApplicationNotFound)
      end
    end

    context 'validations on field are_contact_details_private inclusion' do
      it { should validate_presence_of(:are_contact_details_private, :inclusion) }
    end

    context 'for valid details' do
      let(:expected_attributes) {
        {
          privacy_known: 'yes',
          are_contact_details_private: GenericYesNo::NO,
        }
      }

      context 'when record exists' do
        let(:record) { party }

        it 'updates the record if it already exists' do
          expect(other_parties_collection).to receive(:find_or_initialize_by).with(
            id: 'ae4ed69e-bcb3-49cc-b19e-7287b1f2abe6'
          ).and_return(party)

          expect(party).to receive(:update).with(
            expected_attributes
          ).and_return(true)


          expect(subject.save).to be(true)
        end
      end
    end
  end
end
