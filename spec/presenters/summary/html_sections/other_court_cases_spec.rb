require 'spec_helper'

module Summary
  describe HtmlSections::OtherCourtCases do
    let(:c100_application) {
      instance_double(C100Application,
        children_previous_proceedings: children_previous_proceedings,
        court_proceeding: court_proceeding,
    ) }

    let(:court_proceeding) {
      instance_double(CourtProceeding,
        children_names: 'children_names',
        court_name: 'court_name',
        case_number: 'case_number',
        proceedings_date: 'proceedings_date',
        cafcass_details: 'cafcass_details',
        order_types: 'order_types',
        previous_details: 'previous_details',
    ) }

    let(:children_previous_proceedings) { 'yes' }

    subject { described_class.new(c100_application) }

    let(:answers) { subject.answers }

    describe '#name' do
      it { expect(subject.name).to eq(:other_court_cases) }
    end

    describe '#answers' do
      context 'when there are previous proceedings' do
        let(:children_previous_proceedings) { 'yes' }

        it 'has the correct rows' do
          expect(answers.count).to eq(2)

          expect(answers[0]).to be_an_instance_of(Answer)
          expect(answers[0].question).to eq(:has_other_court_cases)
          expect(answers[0].value).to eq('yes')
          expect(answers[0].change_path).to eq('/steps/application/previous_proceedings')

          expect(answers[1]).to be_an_instance_of(AnswersGroup)
          expect(answers[1].name).to eq(:other_court_cases_details)
          expect(answers[1].change_path).to eq('/steps/application/court_proceedings')
          expect(answers[1].answers.size).to eq(7)
        end
      end

      context 'when there are no previous proceedings' do
        let(:children_previous_proceedings) { 'no' }
        let(:court_proceeding) { nil }

        it 'has the correct rows' do
          expect(answers.count).to eq(1)

          expect(answers[0]).to be_an_instance_of(Answer)
          expect(answers[0].question).to eq(:has_other_court_cases)
          expect(answers[0].value).to eq('no')
          expect(answers[0].change_path).to eq('/steps/application/previous_proceedings')
        end
      end
    end

    describe '#other_court_cases_details' do
      let(:answers){ subject.send(:other_court_cases_details) }

      it 'has the correct rows' do
        expect(answers[0]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[0].question).to eq(:court_proceeding_children_names)
        expect(answers[0].value).to eq('children_names')

        expect(answers[1]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[1].question).to eq(:court_proceeding_court_name)
        expect(answers[1].value).to eq('court_name')

        expect(answers[2]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[2].question).to eq(:court_proceeding_case_number)
        expect(answers[2].value).to eq('case_number')

        expect(answers[3]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[3].question).to eq(:court_proceeding_proceedings_date)
        expect(answers[3].value).to eq('proceedings_date')

        expect(answers[4]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[4].question).to eq(:court_proceeding_cafcass_details)
        expect(answers[4].value).to eq('cafcass_details')

        expect(answers[5]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[5].question).to eq(:court_proceeding_order_types)
        expect(answers[5].value).to eq('order_types')

        expect(answers[6]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[6].question).to eq(:court_proceeding_previous_details)
        expect(answers[6].value).to eq('previous_details')
      end
    end
  end
end
