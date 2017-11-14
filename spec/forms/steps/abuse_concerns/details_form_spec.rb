require 'spec_helper'

RSpec.describe Steps::AbuseConcerns::DetailsForm do
  let(:arguments) { {
    c100_application: c100_application,
    subject: abuse_subject,
    kind: abuse_kind,
    behaviour_description: behaviour_description,
    behaviour_start: behaviour_start,
    behaviour_ongoing: behaviour_ongoing,
    behaviour_stop: behaviour_stop
  } }

  let(:c100_application) { instance_double(C100Application, abuse_concerns: concerns_collection) }
  let(:concerns_collection) { double('concerns_collection') }
  let(:abuse_concern) { double('abuse_concern') }

  let(:abuse_subject) {'applicant'}
  let(:abuse_kind) {'emotional'}
  let(:behaviour_description) { 'a description' }
  let(:behaviour_start) { '1 year ago' }
  let(:behaviour_ongoing) { 'no' }
  let(:behaviour_stop) { 'last monday' }

  subject { described_class.new(arguments) }

  describe '.behaviour_ongoing_choices' do
    it 'returns the relevant choices' do
      expect(described_class.behaviour_ongoing_choices).to eq(%w(yes no))
    end
  end

  describe '.i18n_key' do
    context 'for an applicant subject' do
      let(:abuse_subject) { 'applicant' }
      it { expect(subject.i18n_key).to eq('applicant.emotional') }
    end

    context 'for a children subject' do
      let(:abuse_subject) { 'children' }
      it { expect(subject.i18n_key).to eq('children.emotional') }
    end
  end

  describe '#save' do
    context 'when no c100_application is associated with the form' do
      let(:c100_application) { nil }

      it 'raises an error' do
        expect { subject.save }.to raise_error(BaseForm::C100ApplicationNotFound)
      end
    end

    context 'validations on field presence' do
      it { should validate_presence_of(:behaviour_description) }
      it { should validate_presence_of(:behaviour_start) }
      it { should validate_presence_of(:behaviour_ongoing, :inclusion) }
      it { should validate_presence_of(:behaviour_description) }
      it { should validate_presence_of(:kind, :inclusion) }
    end

    context 'validation on field `behaviour_stop`' do
      context 'when abuse is ongoing' do
        let(:behaviour_ongoing) { 'yes' }
        it { should_not validate_presence_of(:behaviour_stop) }
      end
      context 'when abuse has stopped' do
        let(:behaviour_ongoing) { 'no' }
        it { should validate_presence_of(:behaviour_stop) }
      end
    end

    context 'for valid details' do
      it 'creates the record if it does not exist' do
        expect(concerns_collection).to receive(:find_or_initialize_by).with(
          subject: AbuseSubject::APPLICANT,
          kind: AbuseType::EMOTIONAL
        ).and_return(abuse_concern)

        expect(abuse_concern).to receive(:update).with(
          behaviour_description: 'a description',
          behaviour_start: '1 year ago',
          behaviour_ongoing: GenericYesNo::NO,
          behaviour_stop: 'last monday'
        ).and_return(true)

        expect(subject.save).to be(true)
      end
    end
  end
end
