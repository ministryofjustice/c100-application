require 'spec_helper'

module Summary
  describe Sections::MiamExemptions do
    let(:c100_application) { instance_double(C100Application, miam_exemption: miam_exemption,
                                             exemption_details: exemption_details, exemption_reasons: exemption_reasons,
                                             attach_evidence: attach_evidence,  documents: documents) }
    let(:miam_exemption)   { nil }
    let(:exemption_details) { nil }
    let(:exemption_reasons) { nil }
    let(:attach_evidence) { nil }
    let(:documents) { [double(name: 'file.jpg')] }

    subject { described_class.new(c100_application) }

    let(:answers) { subject.answers }

    describe '#name' do
      it { expect(subject.name).to eq(:miam_exemptions) }
    end

    describe '#show_header?' do
      it { expect(subject.show_header?).to eq(false) }
    end

    describe '#answers' do
      context 'when no exemptions present' do
        let(:miam_exemption) { MiamExemption.new }

        before do
          allow(c100_application.documents(:exemption)).to receive(:none?).and_return(true)
        end

        it 'has the correct number of rows' do
          expect(answers.count).to eq(1)
        end

        it 'has the correct rows in the right order' do
          expect(answers[0]).to be_an_instance_of(Separator)
          expect(answers[0].title).to eq(:not_applicable)
        end
      end

      context 'when there are exemptions' do
        let(:miam_exemption) { MiamExemption.new(domestic: ['court_undertaking']) }
        let(:exemption_details) { "details" }
        let(:exemption_reasons) { "reasons" }
        let(:attach_evidence) { GenericYesNo.new("yes") }

        it 'has the correct number of rows' do
          expect(answers.count).to eq(5)
        end

        it 'has the correct rows in the right order' do
          expect(answers[0]).to be_an_instance_of(Partial)
          expect(answers[0].name).to eq(:miam_exemptions)
          expect(answers[1]).to be_an_instance_of(Partial)
          expect(answers[1].name).to eq(:exemption_details)
          expect(answers[2]).to be_an_instance_of(Partial)
          expect(answers[2].name).to eq(:exemption_reasons)
          expect(answers[3]).to be_an_instance_of(Answer)
          expect(answers[3].question).to eq(:attach_evidence)
          expect(answers[4]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[4].question).to eq(:exemption)
        end

        it 'propagates to the Partial the exemption collection as an ivar' do
          ivar = answers[0].ivar
          expect(ivar.size).to eq(1)
          expect(ivar[0].group_name).to eq(:domestic)
          expect(ivar[0].collection).to eq(['court_undertaking'])
        end
      end
    end
  end
end
