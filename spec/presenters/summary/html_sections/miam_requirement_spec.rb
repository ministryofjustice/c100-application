require 'spec_helper'

module Summary
  describe HtmlSections::MiamRequirement do
    let(:c100_application) {
      instance_double(C100Application,
        miam_attended: 'no',
        miam_certification: 'yes',
        miam_exemption_claim: 'no',
        files_collection_ref: '123'
    ) }

    subject { described_class.new(c100_application) }

    let(:answers) { subject.answers }

    describe '#name' do
      it { expect(subject.name).to eq(:miam_requirement) }
    end

    context 'when no file is present' do

      before do
        allow(Uploader).to receive(:get_file).and_return(nil)
      end

      describe '#answers' do
        it 'has the correct rows' do
          expect(answers.count).to eq(3)

          expect(answers[0]).to be_an_instance_of(Answer)
          expect(answers[0].question).to eq(:miam_attended)
          expect(answers[0].change_path).to eq('/steps/miam/attended')
          expect(answers[0].value).to eq('no')

          expect(answers[1]).to be_an_instance_of(Answer)
          expect(answers[1].question).to eq(:miam_certification)
          expect(answers[1].change_path).to eq('/steps/miam/certification')
          expect(answers[1].value).to eq('yes')

          expect(answers[2]).to be_an_instance_of(Answer)
          expect(answers[2].question).to eq(:miam_exemption_claim)
          expect(answers[2].change_path).to eq('/steps/miam/exemption_claim')
          expect(answers[2].value).to eq('no')
        end
      end

      context 'when a file is present' do
        before do
          allow(Uploader).to receive(:get_file).and_return(
            double(name: 'filename.doc'))
        end

        describe '#answers' do
          it 'has the correct rows' do
            expect(answers.count).to eq(4)

            expect(answers[0]).to be_an_instance_of(Answer)
            expect(answers[0].question).to eq(:miam_attended)
            expect(answers[0].change_path).to eq('/steps/miam/attended')
            expect(answers[0].value).to eq('no')

            expect(answers[1]).to be_an_instance_of(Answer)
            expect(answers[1].question).to eq(:miam_certification)
            expect(answers[1].change_path).to eq('/steps/miam/certification')
            expect(answers[1].value).to eq('yes')

            expect(answers[2]).to be_an_instance_of(Answer)
            expect(answers[2].question).to eq(:miam_exemption_claim)
            expect(answers[2].change_path).to eq('/steps/miam/exemption_claim')
            expect(answers[2].value).to eq('no')

            expect(answers[3]).to be_an_instance_of(FileAnswer)
            expect(answers[3].question).to eq(:miam_certificate)
            expect(answers[3].change_path).to eq('/steps/miam/certification_upload')
            expect(answers[3].value).to eq('filename.doc')
          end
        end


      end

    end
  end
end
