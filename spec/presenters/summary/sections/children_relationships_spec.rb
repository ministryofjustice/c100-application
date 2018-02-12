require 'spec_helper'

module Summary
  describe Sections::ChildrenRelationships do
    let(:c100_application) {
      instance_double(C100Application,
        applicants: applicants,
        respondents: respondents,
        other_parties: other_parties,
      )
    }

    let(:applicants) { double('applicants') }
    let(:respondents) { double('respondents') }
    let(:other_parties) { double('other_parties') }

    subject { described_class.new(c100_application) }

    let(:answers) { subject.answers }

    describe '#name' do
      it 'is expected to be correct' do
        expect(subject.name).to eq(:children_relationships)
      end
    end

    describe '#answers' do
      before do
        allow_any_instance_of(
          RelationshipsPresenter
        ).to receive(:relationship_to_children).with(applicants).and_return('applicants_relationships')

        allow_any_instance_of(
          RelationshipsPresenter
        ).to receive(:relationship_to_children).with(respondents).and_return('respondents_relationships')

        allow_any_instance_of(
          RelationshipsPresenter
        ).to receive(:relationship_to_children).with(other_parties).and_return('other_parties_relationships')
      end

      it 'has the correct number of rows' do
        expect(answers.count).to eq(3)
      end

      it 'has the correct rows in the right order' do
        expect(answers[0]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[0].question).to eq(:applicants_relationships)
        expect(answers[0].value).to eq('applicants_relationships')

        expect(answers[1]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[1].question).to eq(:respondents_relationships)
        expect(answers[1].value).to eq('respondents_relationships')

        expect(answers[2]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[2].question).to eq(:other_parties_relationships)
        expect(answers[2].value).to eq('other_parties_relationships')
      end
    end
  end
end
