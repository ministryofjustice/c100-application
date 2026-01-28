require 'spec_helper'

RSpec.describe Steps::Application::ExistingCourtOrderForm do
  let(:arguments) { {
    c100_application: c100_application,
    existing_court_order: existing_court_order,
    court_order_case_number: court_order_case_number,
    court_order_expiry_date: court_order_expiry_date
  } }

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

    context 'when form is valid' do
      it 'saves the record' do
        expect(c100_application).to receive(:update).with(
          existing_court_order: GenericYesNo::NO,
          court_order_case_number: nil,
          court_order_expiry_date: nil,
          existing_court_order_uploadable: nil
        ).and_return(true)

        expect(subject.save).to be(true)
      end
    end
  end
end
