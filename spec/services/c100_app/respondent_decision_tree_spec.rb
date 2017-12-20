require 'rails_helper'

RSpec.describe C100App::RespondentDecisionTree do
  let(:c100_application) { double('Object') }
  let(:step_params)      { double('Step') }
  let(:next_step)        { nil }
  let(:as)               { nil }
  let(:record)           { nil }

  let(:c100_application) { instance_double(C100Application, respondent_ids: [1, 2, 3], child_ids: [1, 2, 3]) }

  subject {
    described_class.new(
      c100_application: c100_application,
      record: record,
      step_params: step_params,
      as: as,
      next_step: next_step
    )
  }

  it_behaves_like 'a decision tree'

  context 'when the step is `add_another_name`' do
    let(:step_params) {{'add_another_name' => 'anything'}}
    it {is_expected.to have_destination(:names, :edit)}
  end

  context 'when the step is `names_finished`' do
    let(:step_params) {{'names_finished' => 'anything'}}

    it 'goes to edit the details of the first respondent' do
      expect(subject.destination).to eq(controller: :personal_details, action: :edit, id: 1)
    end
  end

  context 'when the step is `personal_details`' do
    let(:step_params) {{'personal_details' => 'anything'}}
    let(:record) {double('Respondent', id: 1)}

    it 'goes to edit the first child relationship for the current record' do
      expect(subject.destination).to eq(controller: :relationship, action: :edit, id: record, child_id: 1)
    end
  end

  context 'when the step is `relationship`' do
    let(:step_params) {{'relationship' => 'anything'}}
    let(:record) { double('Relationship', respondent: respondent, child: child) }

    let(:respondent) { double('Respondent', id: 1) }

    context 'when there are remaining children' do
      let(:child) { double('Child', id: 1) }

      it 'goes to edit the relationship of the next child' do
        expect(subject.destination).to eq(controller: :relationship, action: :edit, id: respondent, child_id: 2)
      end
    end

    context 'when all child relationships have been edited' do
      let(:child) { double('Child', id: 3) }

      it 'goes to edit the contact details of the current respondent' do
        expect(subject.destination).to eq(controller: :contact_details, action: :edit, id: respondent)
      end
    end
  end

  context 'when the step is `contact_details`' do
    let(:step_params) {{'contact_details' => 'anything'}}

    context 'when there are remaining respondents' do
      let(:record) { double('Respondent', id: 1) }

      it 'goes to edit the personal details of the next respondent' do
        expect(subject.destination).to eq(controller: :personal_details, action: :edit, id: 2)
      end
    end

    context 'when all respondents have been edited' do
      let(:record) { double('Respondent', id: 3) }
      it {is_expected.to have_destination(:has_other_parties, :edit)}
    end
  end

  context 'when the step is `has_other_parties`' do
    let(:c100_application) { instance_double(C100Application, has_other_parties: value) }
    let(:step_params) { { has_other_parties: 'anything' } }

    context 'and the answer is `yes`' do
      let(:value) { 'yes' }
      it { is_expected.to have_destination('/steps/other_parties/names', :edit) }
    end

    context 'and the answer is `no`' do
      let(:value) { 'no' }
      it { is_expected.to have_destination('/steps/abuse_concerns/previous_proceedings', :edit) }
    end
  end
end
