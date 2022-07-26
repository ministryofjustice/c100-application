require 'spec_helper'

module Summary
  describe Sections::ApplicationReasons do
    let(:c100_application) {
      instance_double(
        C100Application,
        permission_sought: permission_sought,
        permission_details: permission_details,
        application_details: application_details,
      )
    }

    let(:permission_sought) { nil }
    let(:permission_details) { nil }
    let(:application_details) { 'application details' }

    subject { described_class.new(c100_application) }

    let(:answers) { subject.answers }

    describe '#name' do
      it { expect(subject.name).to eq(:application_reasons) }
    end

    describe '#show_header?' do
      it { expect(subject.show_header?).to eq(false) }
    end

    describe '#answers' do
      context 'when permission details are `nil` (permission not required)' do
        it 'has the correct rows' do
          expect(answers.count).to eq(2)

          expect(answers[0]).to be_an_instance_of(Answer)
          expect(answers[0].question).to eq(:permission_sought)
          expect(answers[0].value).to eq(:not_required)

          expect(answers[1]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[1].question).to eq(:application_details)
          expect(answers[1].value).to eq(application_details)
        end
      end

      context 'when permission sought is `yes`' do
        let(:permission_sought) { 'yes' }

        it 'has the correct rows' do
          expect(answers.count).to eq(2)

          expect(answers[0]).to be_an_instance_of(Answer)
          expect(answers[0].question).to eq(:permission_sought)
          expect(answers[0].value).to eq(permission_sought)

          expect(answers[1]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[1].question).to eq(:application_details)
          expect(answers[1].value).to eq(application_details)
        end
      end

      context 'when permission sought is `no`' do
        let(:permission_sought) { 'no' }
        let(:permission_details) { 'permission details' }

        it 'has the correct rows' do
          expect(answers.count).to eq(3)

          expect(answers[0]).to be_an_instance_of(Answer)
          expect(answers[0].question).to eq(:permission_sought)
          expect(answers[0].value).to eq(permission_sought)

          expect(answers[1]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[1].question).to eq(:permission_details)
          expect(answers[1].value).to eq(permission_details)

          expect(answers[2]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[2].question).to eq(:application_details)
          expect(answers[2].value).to eq(application_details)
        end
      end
    end
  end
end
