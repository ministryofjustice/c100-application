require 'spec_helper'

module Summary
  describe Sections::ApplicationReasons do
    let(:c100_application) {
      instance_double(
        C100Application,
        permission_sought: permission_sought,
        permission_details: permission_details,
        application_details: application_details,
        existing_court_order: existing_court_order,
        court_order_case_number: court_order_case_number,
        court_order_expiry_date: court_order_expiry_date,
        existing_court_order_uploadable: existing_court_order_uploadable,
        documents: documents
      )
    }

    let(:permission_sought) { nil }
    let(:permission_details) { nil }
    let(:application_details) { 'application details' }
    let(:existing_court_order) { 'No' }
    let(:court_order_case_number) { nil }
    let(:court_order_expiry_date) { nil }
    let(:existing_court_order_uploadable) { nil }
    let(:documents) { [double(name: 'file.jpg')] }


    subject { described_class.new(c100_application) }

    let(:answers) { subject.answers }

    before do
      allow(c100_application.documents(:existing_court_order)).to receive(:any?).and_return(false)
    end

    describe '#name' do
      it { expect(subject.name).to eq(:application_reasons) }
    end

    describe '#show_header?' do
      it { expect(subject.show_header?).to eq(false) }
    end

    describe '#answers' do
      context 'when permission details are `nil` (permission not required)' do
        it 'has the correct rows' do
          expect(answers.count).to eq(3)

          expect(answers[0]).to be_an_instance_of(Answer)
          expect(answers[0].question).to eq(:permission_sought)
          expect(answers[0].value).to eq(:not_required)

          expect(answers[1]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[1].question).to eq(:application_details)
          expect(answers[1].value).to eq(application_details)

          expect(answers[2]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[2].question).to eq(:existing_court_order)
          expect(answers[2].value).to eq(existing_court_order)
        end
      end

      context 'when permission sought is `yes`' do
        let(:permission_sought) { 'yes' }

        it 'has the correct rows' do
          expect(answers.count).to eq(3)

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
          expect(answers.count).to eq(4)

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

      context 'when existing_court_order is yes and no file' do
        let(:existing_court_order) { 'Yes' }
        let(:court_order_case_number) { '123' }
        let(:court_order_expiry_date) { Date.new(2026, 1, 2) }
        let(:existing_court_order_uploadable) { 'no' }

        it 'has the correct rows' do
          expect(answers.count).to eq(7)

          expect(answers[0]).to be_an_instance_of(Answer)
          expect(answers[0].question).to eq(:permission_sought)
          expect(answers[0].value).to eq(:not_required)

          expect(answers[1]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[1].question).to eq(:application_details)
          expect(answers[1].value).to eq(application_details)

          expect(answers[2]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[2].question).to eq(:existing_court_order)
          expect(answers[2].value).to eq(existing_court_order)

          expect(answers[3]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[3].question).to eq(:court_order_case_number)
          expect(answers[3].value).to eq(court_order_case_number)

          expect(answers[4]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[4].question).to eq(:court_order_expiry_date)
          expect(answers[4].value).to eq(court_order_expiry_date)

          expect(answers[5]).to be_an_instance_of(Answer)
          expect(answers[5].question).to eq(:existing_court_order_uploadable)
          expect(answers[5].value).to eq(existing_court_order_uploadable)

          expect(answers[6]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[6].question).to eq(:existing_court_order_upload)
          expect(answers[6].value).to eq('[Not applicable in this case]')
        end
      end

      context 'when existing_court_order is yes and yes file' do
        let(:existing_court_order) { 'Yes' }
        let(:court_order_case_number) { '123' }
        let(:court_order_expiry_date) { Date.new(2026, 1, 2) }
        let(:existing_court_order_uploadable) { 'Yes' }

        before do
          allow(c100_application.documents(:existing_court_order)).to receive(:any?).and_return(true)
        end

        it 'has the correct rows' do
          expect(answers.count).to eq(7)

          expect(answers[0]).to be_an_instance_of(Answer)
          expect(answers[0].question).to eq(:permission_sought)
          expect(answers[0].value).to eq(:not_required)

          expect(answers[1]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[1].question).to eq(:application_details)
          expect(answers[1].value).to eq(application_details)

          expect(answers[2]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[2].question).to eq(:existing_court_order)
          expect(answers[2].value).to eq(existing_court_order)

          expect(answers[3]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[3].question).to eq(:court_order_case_number)
          expect(answers[3].value).to eq(court_order_case_number)

          expect(answers[4]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[4].question).to eq(:court_order_expiry_date)
          expect(answers[4].value).to eq(court_order_expiry_date)

          expect(answers[5]).to be_an_instance_of(Answer)
          expect(answers[5].question).to eq(:existing_court_order_uploadable)
          expect(answers[5].value).to eq(existing_court_order_uploadable)

          expect(answers[6]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[6].question).to eq(:existing_court_order_upload)
          expect(answers[6].value).to eq('[ File(s) uploaded with application ]')
        end
      end
    end
  end
end
