require 'spec_helper'

module Summary
  describe HtmlSections::OpeningQuestions do
    let(:c100_application) {
      instance_double(C100Application,
        consent_order: 'no',
        child_protection_cases: 'no',
        files_collection_ref: '123'
    ) }


    subject { described_class.new(c100_application) }

    let(:answers) { subject.answers }

    describe '#name' do
      it { expect(subject.name).to eq(:opening_questions) }
    end

    describe '#show_header?' do
      it { expect(subject.show_header?).to eq(false) }
    end

    context 'when no file is present' do
      before do
        allow(Uploader).to receive(:get_file).and_return(nil)
      end

      describe '#answers' do
        it 'has the correct rows' do
          expect(answers.count).to eq(2)

          expect(answers[0]).to be_an_instance_of(Answer)
          expect(answers[0].question).to eq(:consent_order_application)
          expect(answers[0].change_path).to eq('/steps/opening/consent_order')
          expect(answers[0].value).to eq('no')

          expect(answers[1]).to be_an_instance_of(Answer)
          expect(answers[1].question).to eq(:child_protection_cases)
          expect(answers[1].change_path).to eq('/steps/opening/child_protection_cases')
          expect(answers[1].value).to eq('no')
        end
      end
    end

    context 'when a file is present' do
      before do
        allow(Uploader).to receive(:get_file).and_return(
          double(name: 'filename.doc'))
      end

      describe '#answers' do
        it 'has the correct rows' do
          expect(answers.count).to eq(3)

          expect(answers[0]).to be_an_instance_of(Answer)
          expect(answers[0].question).to eq(:consent_order_application)
          expect(answers[0].change_path).to eq('/steps/opening/consent_order')
          expect(answers[0].value).to eq('no')

          expect(answers[1]).to be_an_instance_of(FileAnswer)
          expect(answers[1].question).to eq(:consent_order_upload)
          expect(answers[1].change_path).to eq('/steps/opening/consent_order_upload')
          expect(answers[1].value).to eq('filename.doc')

          expect(answers[2]).to be_an_instance_of(Answer)
          expect(answers[2].question).to eq(:child_protection_cases)
          expect(answers[2].change_path).to eq('/steps/opening/child_protection_cases')
          expect(answers[2].value).to eq('no')
        end
      end
    end
  end
end
