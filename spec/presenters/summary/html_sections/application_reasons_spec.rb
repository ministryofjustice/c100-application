require 'spec_helper'

module Summary
  describe HtmlSections::ApplicationReasons do
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
        files_collection_ref: '123'
      )
    }

    let(:permission_sought) { nil }
    let(:permission_details) { nil }
    let(:application_details) { 'application details' }
    let(:existing_court_order) { 'No' }
    let(:court_order_case_number) { nil }
    let(:court_order_expiry_date) { nil }
    let(:existing_court_order_uploadable) { nil }


    subject { described_class.new(c100_application) }

    let(:answers) { subject.answers }

    before do
      allow(Uploader).to receive(:get_file).and_return(nil)
    end

    describe '#name' do
      it { expect(subject.name).to eq(:application_reasons) }
    end

    describe '#answers' do
      context 'when permission question was not asked' do
        it 'has the correct rows' do
          expect(answers.count).to eq(2)

          expect(answers[0]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[0].question).to eq(:application_details)
          expect(answers[0].value).to eq(application_details)
          expect(answers[0].change_path).to eq('/steps/application/details')
          expect(answers[1]).to be_an_instance_of(AnswersGroup)
          expect(answers[1].name).to eq(:existing_court_order)
          expect(answers[1].answers.first).to be_an_instance_of(FreeTextAnswer)
          expect(answers[1].answers.first.question).to eq(:existing_court_order)
          expect(answers[1].answers.first.value).to eq(existing_court_order)
          expect(answers[1].change_path).to eq('/steps/application/existing_court_order')
        end
      end

      context 'when permission sought is `yes`' do
        let(:permission_sought) { 'yes' }

        it 'has the correct rows' do
          expect(answers.count).to eq(3)

          expect(answers[0]).to be_an_instance_of(Answer)
          expect(answers[0].question).to eq(:permission_sought)
          expect(answers[0].value).to eq(permission_sought)
          expect(answers[0].change_path).to eq('/steps/application/permission_sought')

          expect(answers[1]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[1].question).to eq(:application_details)
          expect(answers[1].value).to eq(application_details)
          expect(answers[1].change_path).to eq('/steps/application/details')

          expect(answers[2]).to be_an_instance_of(AnswersGroup)
          expect(answers[2].name).to eq(:existing_court_order)
          expect(answers[2].answers.first).to be_an_instance_of(FreeTextAnswer)
          expect(answers[2].answers.first.question).to eq(:existing_court_order)
          expect(answers[2].answers.first.value).to eq(existing_court_order)
          expect(answers[2].change_path).to eq('/steps/application/existing_court_order')
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
          expect(answers[0].change_path).to eq('/steps/application/permission_sought')

          expect(answers[1]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[1].question).to eq(:permission_details)
          expect(answers[1].value).to eq(permission_details)
          expect(answers[1].change_path).to eq('/steps/application/permission_details')

          expect(answers[2]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[2].question).to eq(:application_details)
          expect(answers[2].value).to eq(application_details)
          expect(answers[2].change_path).to eq('/steps/application/details')

          expect(answers[3]).to be_an_instance_of(AnswersGroup)
          expect(answers[3].name).to eq(:existing_court_order)
          expect(answers[3].answers.first).to be_an_instance_of(FreeTextAnswer)
          expect(answers[3].answers.first.question).to eq(:existing_court_order)
          expect(answers[3].answers.first.value).to eq(existing_court_order)
          expect(answers[3].change_path).to eq('/steps/application/existing_court_order')
        end
      end

      context 'when existing_court_order is yes and uploadable no' do
        let(:existing_court_order) { 'Yes' }
        let(:court_order_case_number) { '123' }
        let(:court_order_expiry_date) { Date.new(2026, 1, 2) }
        let(:existing_court_order_uploadable) { 'No' }

        it 'has the correct rows' do
          expect(answers.count).to eq(3)

          expect(answers[0]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[0].question).to eq(:application_details)
          expect(answers[0].value).to eq(application_details)
          expect(answers[0].change_path).to eq('/steps/application/details')

          expect(answers[1]).to be_an_instance_of(AnswersGroup)
          expect(answers[1].name).to eq(:existing_court_order)
          expect(answers[1].change_path).to eq('/steps/application/existing_court_order')

          existing_court_group_output = answers[1].answers

          expect(existing_court_group_output[0]).to be_an_instance_of(FreeTextAnswer)
          expect(existing_court_group_output[0].question).to eq(:existing_court_order)
          expect(existing_court_group_output[0].value).to eq(existing_court_order)

          expect(existing_court_group_output[1]).to be_an_instance_of(FreeTextAnswer)
          expect(existing_court_group_output[1].question).to eq(:court_order_case_number)
          expect(existing_court_group_output[1].value).to eq(court_order_case_number)

          expect(existing_court_group_output[2]).to be_an_instance_of(FreeTextAnswer)
          expect(existing_court_group_output[2].question).to eq(:court_order_expiry_date)
          expect(existing_court_group_output[2].value).to eq(court_order_expiry_date)

          expect(answers[2]).to be_an_instance_of(Answer)
          expect(answers[2].question).to eq(:existing_court_order_uploadable)
          expect(answers[2].value).to eq(existing_court_order_uploadable)
          expect(answers[2].change_path).to eq('/steps/application/existing_court_order_uploadable')
        end
      end

      context 'when existing_court_order is yes and uploadable yes' do
        let(:existing_court_order) { 'Yes' }
        let(:court_order_case_number) { '123' }
        let(:court_order_expiry_date) { Date.new(2026, 1, 2) }
        let(:existing_court_order_uploadable) { 'Yes' }

        before do
          allow(Uploader).to receive(:get_file).and_return(
            double(name: 'filename.doc'))
        end

        it 'has the correct rows' do
          expect(answers.count).to eq(4)

          expect(answers[0]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[0].question).to eq(:application_details)
          expect(answers[0].value).to eq(application_details)
          expect(answers[0].change_path).to eq('/steps/application/details')

          expect(answers[1]).to be_an_instance_of(AnswersGroup)
          expect(answers[1].name).to eq(:existing_court_order)
          expect(answers[1].change_path).to eq('/steps/application/existing_court_order')

          existing_court_group_output = answers[1].answers

          expect(existing_court_group_output[0]).to be_an_instance_of(FreeTextAnswer)
          expect(existing_court_group_output[0].question).to eq(:existing_court_order)
          expect(existing_court_group_output[0].value).to eq(existing_court_order)

          expect(existing_court_group_output[1]).to be_an_instance_of(FreeTextAnswer)
          expect(existing_court_group_output[1].question).to eq(:court_order_case_number)
          expect(existing_court_group_output[1].value).to eq(court_order_case_number)

          expect(existing_court_group_output[2]).to be_an_instance_of(FreeTextAnswer)
          expect(existing_court_group_output[2].question).to eq(:court_order_expiry_date)
          expect(existing_court_group_output[2].value).to eq(court_order_expiry_date)

          expect(answers[2]).to be_an_instance_of(Answer)
          expect(answers[2].question).to eq(:existing_court_order_uploadable)
          expect(answers[2].value).to eq(existing_court_order_uploadable)
          expect(answers[2].change_path).to eq('/steps/application/existing_court_order_uploadable')

          expect(answers[3]).to be_an_instance_of(FileAnswer)
          expect(answers[3].question).to eq(:existing_court_order_upload)
          expect(answers[3].value).to eq('filename.doc')
          expect(answers[3].change_path).to eq('/steps/application/existing_court_order_upload')
        end
      end
    end
  end
end
