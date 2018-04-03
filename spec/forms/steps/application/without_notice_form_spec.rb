require 'spec_helper'

RSpec.describe Steps::Application::WithoutNoticeForm do
  it_behaves_like 'a yes-no question form', attribute_name: :without_notice

  context 'when the user selects NO' do
    let(:c100_application){ instance_double(C100Application, without_notice: without_notice) }
    let(:without_notice){ GenericYesNo::NO }
    let(:arguments){
      {
        c100_application: c100_application,
        without_notice: GenericYesNo::NO
      }
    }
    subject { described_class.new(arguments) }

    it 'resets all details fields' do
      expect(c100_application).to receive(:update).with({
        without_notice: GenericYesNo::NO,
        without_notice_details: nil,
        without_notice_frustrate: nil,
        without_notice_frustrate_details: nil,
        without_notice_impossible: nil,
        without_notice_impossible_details: nil,
      })
      subject.save
    end
  end
end
