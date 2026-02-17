require 'spec_helper'

RSpec.describe Steps::Application::ExistingCourtOrderForm do
  let(:arguments) do
    {
      c100_application: c100_application,
      existing_court_order: existing_court_order,
      court_order_case_number: court_order_case_number,
      court_order_expiry_date: court_order_expiry_date
    }
  end

  let(:c100_application) { instance_double(C100Application) }

  let(:existing_court_order) { GenericYesNo::NO }
  let(:court_order_case_number) { nil }
  let(:court_order_expiry_date) { nil }

  subject { described_class.new(arguments) }

  describe '#save' do
    context 'when no c100_application is associated with the form' do
      let(:c100_application) { nil }

      it 'raises an error' do
        expect { subject.save }.to raise_error(BaseForm::C100ApplicationNotFound)
      end
    end

    context 'validations' do
      context 'when existing_court_order is not provided' do
        let(:existing_court_order) { nil }
        let(:court_order_expiry_date) { [nil, 0, 0, 0] }

        it 'is not valid' do
          expect(subject).not_to be_valid
        end
      end

      context 'when existing_court_order is yes' do
        let(:existing_court_order) { GenericYesNo::YES }
        let(:court_order_expiry_date) { [nil, 0, 0, 0] }

        context 'without case number' do
          let(:court_order_case_number) { nil }

          it 'is valid' do
            expect(subject).to be_valid
          end
        end

        context 'without expiry date' do
          it 'is valid' do
            expect(subject).to be_valid
          end
        end
      end
    end

    context 'when existing_court_order is no' do
      it 'saves the record with reset attributes' do
        expect(c100_application).to receive(:update).with(
          existing_court_order: GenericYesNo::NO,
          court_order_case_number: nil,
          court_order_expiry_date: nil,
          existing_court_order_uploadable: nil
        ).and_return(true)

        expect(subject.save).to be(true)
      end
    end

    context 'when existing_court_order is yes' do
      let(:existing_court_order) { GenericYesNo::YES }
      let(:court_order_case_number) { 'ABC123' }
      let(:court_order_expiry_date) { [nil, 2027, 6, 15] }

      it 'saves the record with provided attributes' do
        expect(c100_application).to receive(:existing_court_order_uploadable).and_return('yes')
        expect(c100_application).to receive(:update).with(
          existing_court_order: GenericYesNo::YES,
          court_order_case_number: 'ABC123',
          court_order_expiry_date: Date.new(2027, 6, 15),
          existing_court_order_uploadable: 'yes'
        ).and_return(true)

        expect(subject.save).to be(true)
      end
    end
  end
end
