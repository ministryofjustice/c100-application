require 'spec_helper'

module Summary
  describe Sections::MediatorCertification do
    let(:c100_application) { instance_double(C100Application, miam_certification: miam_certification) }

    let(:miam_certification) { 'yes' }

    subject { described_class.new(c100_application) }

    let(:answers) { subject.answers }

    describe '#name' do
      it { expect(subject.name).to eq(:mediator_certification) }
    end

    describe '#show_header?' do
      it { expect(subject.show_header?).to eq(false) }
    end

    describe '#answers' do
      it 'has the correct rows' do
        expect(answers.count).to eq(1)

        expect(answers[0]).to be_an_instance_of(Separator)
        expect(answers[0].title).to eq(:hmcts_instructions)
      end

      context 'when no certification received' do
        let(:miam_certification) { 'no' }

        it 'has the correct rows' do
          expect(answers.count).to eq(1)

          expect(answers[0]).to be_an_instance_of(Separator)
          expect(answers[0].title).to eq(:not_applicable)
        end
      end
    end
  end
end
