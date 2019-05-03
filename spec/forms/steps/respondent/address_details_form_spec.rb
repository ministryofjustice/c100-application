require 'spec_helper'

RSpec.describe Steps::Respondent::AddressDetailsForm do

  it_behaves_like 'a address CRUD form', Respondent

  let(:arguments) do
    {
      c100_application: c100_application,
      record: record,
      address: address,
      address_line_1: address_line_1,
      address_line_2: address_line_2,
      town: town,
      country: country,
      postcode: postcode,
      address: address,
      address_unknown: address_unknown,
      residence_requirement_met: residence_requirement_met,
      residence_history: residence_history
    }
  end
  let(:c100_application) { instance_double(C100Application, respondents: respondents_collection) }
  let(:respondents_collection) { double('respondents_collection') }
  let(:respondent) { double('Respondent', id: 'ae4ed69e-bcb3-49cc-b19e-7287b1f2abe9') }
  let(:respondent_1) { double('Respondent', id: 'ae4ed69e-bcb3-49cc-b19e-7287b1f2abe1') }

  let(:record) { nil }
  let(:address) { 'address' }
  let(:address_unknown) { false }
  let(:residence_requirement_met) { 'no' }
  let(:residence_history) { 'history' }

  let(:address_line_1) { nil }
  let(:address_line_2) { nil }
  let(:town) { nil }
  let(:country) { nil }
  let(:postcode) { nil }
  let(:split_address_result) { false }

  before do
    allow(subject).to receive(:split_address?).and_return(split_address_result)
  end

  subject { described_class.new(arguments) }

  describe '#save' do

    context 'for valid details' do
      let(:expected_attributes) {
        {
          address: 'address',
          address_unknown: false,
          residence_requirement_met: GenericYesNoUnknown::NO,
          residence_history: 'history'
        }
      }

      context 'when record does not exist' do
        let(:record) { nil }

        it 'creates the record if it does not exist' do
          expect(respondents_collection).to receive(:find_or_initialize_by).with(
            id: nil
          ).and_return(respondent)

          expect(respondent).to receive(:update).with(
            expected_attributes
          ).and_return(true)

          expect(subject.save).to be(true)
        end
      end

      context 'when record already exists' do
        let(:record) { respondent }

        it 'updates the record if it already exists' do
          expect(respondents_collection).to receive(:find_or_initialize_by).with(
            id: 'ae4ed69e-bcb3-49cc-b19e-7287b1f2abe9'
          ).and_return(respondent)

          expect(respondent).to receive(:update).with(
            expected_attributes
          ).and_return(true)

          expect(subject.save).to be(true)
        end
      end
    end

    context 'when split address' do
      let(:split_address_result) { true }

      let(:address_data) do
        {
          address_line_1: address_line_1,
          address_line_2: address_line_2,
          town: town,
          country: country,
          postcode: postcode
        }
      end

      context 'validations on field presence unless `unknown`' do
        it { should validate_presence_of(:address_line_1) }
        it { should validate_presence_of(:postcode) }
      end

      context 'address_line_1' do
        context 'when attribute is not given' do
          let(:address_line_1) { nil }

          it 'returns false' do
            expect(subject.save).to be(false)
          end

          it 'has a validation error on the field' do
            expect(subject).to_not be_valid
            expect(subject.errors[:address_line_1]).to_not be_empty
          end
        end
      end

      context 'for valid details' do
        let(:expected_attributes) {
          {
            address_data: address_data,
            address_unknown: false,
            residence_requirement_met: GenericYesNoUnknown::NO,
            residence_history: 'history'
          }
        }

        context 'when record does not exist' do
          let(:record) { nil }
          let(:address_line_1) { 'address_line_1' }
          let(:address_line_2) { 'address_line_2' }
          let(:town) { 'town' }
          let(:country) { 'c' }
          let(:postcode) { 'postcode' }

          it 'creates the record if it does not exist' do
            expect(respondents_collection).to receive(:find_or_initialize_by).with(
              id: nil
            ).and_return(respondent)

            expect(respondent).to receive(:update).with(
              expected_attributes
            ).and_return(true)

            expect(subject.save).to be(true)
          end
        end

        context 'when record already exists' do
          let(:record) { respondent }
          let(:address_line_1) { 'address_line_1' }
          let(:address_line_2) { 'address_line_2' }
          let(:town) { 'town' }
          let(:country) { 'c' }
          let(:postcode) { 'postcode' }

          it 'updates the record if it already exists' do
            expect(respondents_collection).to receive(:find_or_initialize_by).with(
              id: 'ae4ed69e-bcb3-49cc-b19e-7287b1f2abe9'
            ).and_return(respondent)

            expect(respondent).to receive(:update).with(
              expected_attributes
            ).and_return(true)

            expect(subject.save).to be(true)
          end
        end
      end
    end
  end
end
