require 'rails_helper'

RSpec.describe C100App::OtherPartyDecisionTree do
  let(:c100_application) { double('Object') }
  let(:step_params)      { double('Step') }
  let(:next_step)        { nil }
  let(:as)               { nil }
  let(:record)           { nil }

  let(:c100_application) { instance_double(C100Application, other_party_ids: [1, 2, 3], minor_ids: [1, 2, 3]) }

  subject {
    described_class.new(
      c100_application: c100_application,
      record: record,
      step_params: step_params,
      as: as,
      next_step: next_step
    )
  }

  before do
    allow(PrivacyChange).to receive(:changes_apply?).and_return(true)
  end

  it_behaves_like 'a decision tree'

  context 'when the step is `add_another_name`' do
    let(:step_params) {{'add_another_name' => 'anything'}}
    it {is_expected.to have_destination(:names, :edit)}
  end

  context 'when the step is `names_finished`' do
    let(:step_params) {{'names_finished' => 'anything'}}

    it 'goes to edit the details of the first party' do
      expect(subject.destination).to eq(controller: '/steps/other_party/children_cohabit_other', action: :edit, id: 1)
    end
  end

  context 'when the step is `personal_details`' do
    let(:step_params) {{'personal_details' => 'anything'}}
    let(:record) {double('OtherParty', id: 1)}

    it 'goes to edit the first child relationship for the current record' do
      expect(subject.destination).to eq(controller: :relationship, action: :edit, id: record, child_id: 1)
    end
  end

  context 'when the step is `relationship`' do
    let(:step_params) {{'relationship' => 'anything'}}
    let(:record) { double('Relationship', person: other_party, minor: child) }
    let(:child) { double('Child', id: 3) }

    let(:other_party) { OtherParty.new }

    context 'when there are remaining children' do
      let(:child) { double('Child', id: 1) }

      it 'goes to edit the relationship of the next child' do
        expect(subject.destination).to eq(controller: '/steps/other_party/relationship', action: :edit, id: other_party, child_id: 2)
      end
    end

    context 'when all child relationships have been edited' do
      include_examples 'address lookup decision tree' do
        let(:person) { other_party }
        let(:namespace) { 'other_party' }
      end
    end
  end

  context 'when the step is children_cohabit_other' do
    let(:step_params) {{'cohabit_with_other' => 'anything'}}
    let(:record) { double('Relationship', person: other_party) }
    let(:other_party) { OtherParty.new }

    before do
      allow(record).to receive(:reload).and_return(other_party)
      allow(record).to receive(:id).and_return(other_party)
    end

    context 'when cohabit_with_other is yes' do
      let(:other_party) { OtherParty.new(cohabit_with_other: 'yes') }

      it 'goes to edit the privacy_preferences page' do
        expect(subject.destination).to eq(controller: :privacy_preferences, action: :edit, id: other_party)
      end
    end

    context 'when cohabit_with_other is no' do
      let(:other_party) { OtherParty.new(cohabit_with_other: 'no') }

      it 'goes to edit the personal_details page' do
        expect(subject.destination).to eq(controller: :personal_details, action: :edit, id: other_party)
      end
    end
  end

  context 'when the step is `address_details`' do
    let(:step_params) {{'address_details' => 'anything'}}

    context 'when there are remaining parties' do
      let(:record) { double('OtherParty', id: 1) }

      it 'goes to edit the personal details of the next party' do
        expect(subject.destination).to eq(controller: '/steps/other_party/children_cohabit_other', action: :edit, id: 2)
      end
    end

    context 'when all parties have been edited' do
      let(:record) { double('OtherParty', id: 3) }
      let(:c100_application) { instance_double(C100Application, other_party_ids: [1, 2, 3], child_ids: [1, 2, 3]) }

      it 'goes to edit the residence of the first child' do
        expect(subject.destination).to eq(controller: '/steps/children/residence', action: :edit, id: 1)
      end
    end
  end







  context 'when the step is `privacy_preferences`' do
    let(:step_params) {{'privacy_preferences' => 'anything'}}
    let(:record) { double('OtherParty', id: 1) }
    let(:other_party) { OtherParty.new }

    before do
      allow(record).to receive(:reload).and_return(record)
      allow(record).to receive(:id).and_return(record)
      allow(record).to receive(:are_contact_details_private).and_return(record)
    end

    context 'When CONFIDENTIAL_OPTION_DATE is true' do

      before do
        allow(ConfidentialOption).to receive(:changes_apply?).and_return(true)
      end

      context 'when privacy_preferences is yes' do
        let(:other_party) { OtherParty.new(are_contact_details_private: 'yes') }
        it 'goes to edit the privacy preferences page' do
          expect(subject.destination).to eq(controller: :refuge, action: :edit, id: record)
        end
      end

      context 'when privacy_preferences is no' do
        let(:other_party) { OtherParty.new(are_contact_details_private: 'no') }
        it 'goes to edit the privacy preferences page' do
          expect(subject.destination).to eq(controller: :personal_details, action: :edit, id: record)
        end
      end
    end

    context 'When CONFIDENTIAL_OPTION_DATE is false' do

      before do
        allow(ConfidentialOption).to receive(:changes_apply?).and_return(false)
      end

      it 'goes to edit the privacy preferences page' do
        expect(subject.destination).to eq(controller: :personal_details, action: :edit, id: record)
      end
    end
  end








  context 'when the step is `refuge`' do
    let(:step_params) {{'refuge' => 'anything'}}
    let(:record) { double('OtherParty', id: 1) }

    it 'goes to edit the refuge page' do
      expect(subject.destination).to eq(controller: :personal_details, action: :edit, id: 1)
    end
  end
end
