require 'spec_helper'

module Summary
  describe Sections::DomesticAbuseAct do

    let(:c100_application) { instance_double(C100Application) }
    subject { described_class.new(c100_application, name: :custom_name) }

    describe '#name' do
      it 'is expected to be correct' do
        expect(subject.name).to eq(:domestic_abuse_act)
      end
    end

    describe '#to_partial_path' do
      it 'is expected to be correct' do
        expect(subject.to_partial_path).to eq('steps/completion/shared/domestic_abuse_act')
      end
    end

  end
end
