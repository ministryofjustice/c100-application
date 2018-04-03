require 'spec_helper'

RSpec.describe Steps::Miam::AttendedForm do
  it_behaves_like 'a yes-no question form', attribute_name: :miam_attended

  context 'when attended is no' do
    let(:arguments){
      {
        c100_application: c100_application,
        miam_attended: GenericYesNo::NO
      }
    }
    subject { described_class.new(arguments) }
    let(:c100_application){ instance_double(C100Application) }

    it 'resets the miam certification details' do
      expect(c100_application).to receive(:update).with(
        {
          miam_attended: GenericYesNo::NO,
          miam_certification: nil,
          miam_certification_date: nil,
          miam_certification_number: nil,
          miam_certification_service_name: nil,
          miam_certification_sole_trader_name: nil
        }
      )
      subject.save
    end
  end
end
