require 'spec_helper'

RSpec.describe Steps::Children::ParentalResponsibilityForm do
  let(:arguments) { {
    c100_application: c100_application,
    record: record,
    parental_responsibility: parental_responsibility,
  } }

  let(:c100_application) { instance_double(C100Application, children: children_collection) }
  let(:children_collection) { double('children_collection') }
  let(:child) { double('Child', id: 'ae4ed69e-bcb3-49cc-b19e-7287b1f2abe6') }

  let(:record) { nil }
  let(:parental_responsibility) { 'The mother is responsible for this child' }

  subject { described_class.new(arguments) }

  describe '#save' do
    context 'when no c100_application is associated with the form' do
      let(:c100_application) { nil }

      it 'raises an error' do
        expect { subject.save }.to raise_error(BaseForm::C100ApplicationNotFound)
      end
    end

    context 'validations' do
      it { should validate_presence_of(:parental_responsibility) }
    end

    context 'when a record exists' do
      let(:record) { child }

      it 'saves the record' do
        expect(children_collection).to receive(:find_by!).with(
          id: 'ae4ed69e-bcb3-49cc-b19e-7287b1f2abe6',
        ).and_return(child)

        expect(child).to receive(:update).with(
          parental_responsibility: parental_responsibility,
        ).and_return(true)

        expect(subject.save).to be true
      end
    end

    context 'when a record does not exist' do
      let(:children_collection) { Child.unscoped }
      let(:record) { child }

      it 'raises a not found exception' do
        expect {
          subject.save
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
