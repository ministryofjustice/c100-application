require 'spec_helper'

module Summary
  describe Sections::C1aApplicantAbuseSummary do
    let(:c100_application) { instance_double(C100Application, abuse_concerns: abuse_concerns_resultset) }
    let(:abuse_concerns_resultset) { double('abuse_concerns_resultset').as_null_object }
    let(:abuse_list) { [AbuseType::PHYSICAL, AbuseType::EMOTIONAL, AbuseType::PSYCHOLOGICAL, AbuseType::SEXUAL, AbuseType::FINANCIAL] }

    subject { described_class.new(c100_application) }

    let(:answers) { subject.answers }

    describe '#name' do
      it 'is expected to be correct' do
        expect(subject.name).to eq(:c1a_applicant_abuse_summary)
      end
    end

    def check_finder_received(kind)
      expect(
        abuse_concerns_resultset
      ).to have_received(:where).with(
        subject: AbuseSubject::APPLICANT, kind: kind
      )
    end

    describe '#answers' do
      it 'has the correct number of rows' do
        expect(answers.count).to eq(5)
      end

      it 'has the correct rows in the right order' do
        expect(answers[0]).to be_an_instance_of(Answer)
        expect(answers[0].question).to eq(:c1a_abuse_physical)
        expect(answers[0].value).to eq(abuse_concerns_resultset)

        check_finder_received(abuse_list)

        expect(answers[1]).to be_an_instance_of(Answer)
        expect(answers[1].question).to eq(:c1a_abuse_emotional)

        expect(answers[2]).to be_an_instance_of(Answer)
        expect(answers[2].question).to eq(:c1a_abuse_psychological)

        expect(answers[3]).to be_an_instance_of(Answer)
        expect(answers[3].question).to eq(:c1a_abuse_sexual)

        expect(answers[4]).to be_an_instance_of(Answer)
        expect(answers[4].question).to eq(:c1a_abuse_financial)
      end

      context 'defaults to `NO` when abuse concern was not found' do
        before do
          allow(abuse_concerns_resultset).to receive(:where).and_return(nil)
        end

        it 'has the correct rows in the right order' do
          expect(answers[0]).to be_an_instance_of(Answer)
          expect(answers[0].question).to eq(:c1a_abuse_physical)
          expect(answers[0].value).to eq(GenericYesNo::NO)
        end
      end
    end
  end
end
