require 'spec_helper'

module Summary
  describe HtmlSections::MiamExemptions do
    let(:c100_application) {
      instance_double(C100Application,
        miam_exemption: miam_exemption,
                      exemption_details: exemption_details,
                      exemption_reasons: exemption_reasons,
                      attach_evidence: attach_evidence,
                      files_collection_ref: '123'
    ) }

    let(:miam_exemption) {
      MiamExemption.new(
        domestic: [:test_domestic],
        protection: [:test_protection],
        urgency: [:test_urgency],
        adr: [:test_adr],
        misc: [:test_misc],
      )
    }

    let(:exemption_details) { "details" }
    let(:exemption_reasons) { "reasons" }
    let(:attach_evidence) { GenericYesNo.new('yes') }

    subject { described_class.new(c100_application) }

    let(:answers) { subject.answers }

    describe '#name' do
      it { expect(subject.name).to eq(:miam_exemptions) }
    end

    describe '#answers' do
      context 'when no file is present' do

        before do
          allow(Uploader).to receive(:get_file).and_return(nil)
        end

        it 'has the correct rows' do
          expect(answers.count).to eq(8)

          expect(answers[0]).to be_an_instance_of(MultiAnswer)
          expect(answers[0].question).to eq(:miam_exemptions_domestic)
          expect(answers[0].value).to eq(['test_domestic'])
          expect(answers[0].change_path).to eq('/steps/miam_exemptions/domestic')

          expect(answers[1]).to be_an_instance_of(MultiAnswer)
          expect(answers[1].question).to eq(:miam_exemptions_protection)
          expect(answers[1].value).to eq(['test_protection'])
          expect(answers[1].change_path).to eq('/steps/miam_exemptions/protection')

          expect(answers[2]).to be_an_instance_of(MultiAnswer)
          expect(answers[2].question).to eq(:miam_exemptions_urgency)
          expect(answers[2].value).to eq(['test_urgency'])
          expect(answers[2].change_path).to eq('/steps/miam_exemptions/urgency')

          expect(answers[3]).to be_an_instance_of(MultiAnswer)
          expect(answers[3].question).to eq(:miam_exemptions_adr)
          expect(answers[3].value).to eq(['test_adr'])
          expect(answers[3].change_path).to eq('/steps/miam_exemptions/adr')

          expect(answers[4]).to be_an_instance_of(MultiAnswer)
          expect(answers[4].question).to eq(:miam_exemptions_misc)
          expect(answers[4].value).to eq(['test_misc'])
          expect(answers[4].change_path).to eq('/steps/miam_exemptions/misc')

          expect(answers[5]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[5].question).to eq(:exemption_details)
          expect(answers[5].value).to eq('details')
          expect(answers[5].change_path).to eq('/steps/miam_exemptions/exemption_details')

          expect(answers[6]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[6].question).to eq(:exemption_reasons)
          expect(answers[6].value).to eq('reasons')
          expect(answers[6].change_path).to eq('/steps/miam_exemptions/exemption_reasons')

          expect(answers[7]).to be_an_instance_of(Answer)
          expect(answers[7].question).to eq(:attach_evidence)
          expect(answers[7].value).to eq(GenericYesNo::YES)
          expect(answers[7].change_path).to eq('/steps/miam_exemptions/exemption_reasons')
        end
      end
      context 'when a file is present' do

        before do
          allow(Uploader).to receive(:get_file).and_return(
            double(name: 'filename.doc'))
        end

        it 'has the correct rows' do
          expect(answers.count).to eq(9)

          expect(answers[0]).to be_an_instance_of(MultiAnswer)
          expect(answers[0].question).to eq(:miam_exemptions_domestic)
          expect(answers[0].value).to eq(['test_domestic'])
          expect(answers[0].change_path).to eq('/steps/miam_exemptions/domestic')

          expect(answers[1]).to be_an_instance_of(MultiAnswer)
          expect(answers[1].question).to eq(:miam_exemptions_protection)
          expect(answers[1].value).to eq(['test_protection'])
          expect(answers[1].change_path).to eq('/steps/miam_exemptions/protection')

          expect(answers[2]).to be_an_instance_of(MultiAnswer)
          expect(answers[2].question).to eq(:miam_exemptions_urgency)
          expect(answers[2].value).to eq(['test_urgency'])
          expect(answers[2].change_path).to eq('/steps/miam_exemptions/urgency')

          expect(answers[3]).to be_an_instance_of(MultiAnswer)
          expect(answers[3].question).to eq(:miam_exemptions_adr)
          expect(answers[3].value).to eq(['test_adr'])
          expect(answers[3].change_path).to eq('/steps/miam_exemptions/adr')

          expect(answers[4]).to be_an_instance_of(MultiAnswer)
          expect(answers[4].question).to eq(:miam_exemptions_misc)
          expect(answers[4].value).to eq(['test_misc'])
          expect(answers[4].change_path).to eq('/steps/miam_exemptions/misc')

          expect(answers[5]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[5].question).to eq(:exemption_details)
          expect(answers[5].value).to eq('details')
          expect(answers[5].change_path).to eq('/steps/miam_exemptions/exemption_details')

          expect(answers[6]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[6].question).to eq(:exemption_reasons)
          expect(answers[6].value).to eq('reasons')
          expect(answers[6].change_path).to eq('/steps/miam_exemptions/exemption_reasons')

          expect(answers[7]).to be_an_instance_of(Answer)
          expect(answers[7].question).to eq(:attach_evidence)
          expect(answers[7].value).to eq(GenericYesNo::YES)
          expect(answers[7].change_path).to eq('/steps/miam_exemptions/exemption_reasons')

          expect(answers[8]).to be_an_instance_of(FileAnswer)
          expect(answers[8].question).to eq(:exemption)
          expect(answers[8].value).to eq('filename.doc')
          expect(answers[8].change_path).to eq('/steps/miam_exemptions/exemption_upload')
        end
      end
    end
  end
end
