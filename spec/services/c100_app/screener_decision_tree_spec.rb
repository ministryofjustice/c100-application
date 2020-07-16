require 'rails_helper'

RSpec.describe C100App::ScreenerDecisionTree do
  let(:postcodes)        { 'anything' }
  let(:local_court)      { {} }
  let(:screener_answers) { double('screener_answers', children_postcodes: postcodes, local_court: local_court) }
  let(:c100_application) { double('Object', screener_answers: screener_answers) }
  let(:step_params)      { double('Step') }
  let(:next_step)        { nil }
  let(:as)               { nil }

  subject { described_class.new(c100_application: c100_application, step_params: step_params, as: as, next_step: next_step) }

  it_behaves_like 'a decision tree'

  context 'when the step is `children_postcodes`' do
    let(:step_params) { { children_postcodes: postcodes } }

    context 'and no valid courts are found' do
      before do
        allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:courts_for).with(postcodes).and_return([])
      end
      it { is_expected.to have_destination(:no_court_found, :show) }
    end

    context 'and at least one valid court is found' do
      let(:courts){
        ['i am a court',
         'i am another court']
      }
      let(:court){ instance_double('Court') }

      before do
        allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:courts_for).with(postcodes).and_return(courts)
        allow(screener_answers).to receive(:update!)
        allow(Court).to receive(:new).and_return(court)
      end

      it { is_expected.to have_destination(:parent, :edit) }

      it 'creates a Court from the first result' do
        expect(Court).to receive(:new).with(courts.first)
        subject.destination
      end

      it 'updates the screener_answers with the Court' do
        expect(screener_answers).to receive(:update!).with(local_court: court)
        subject.destination
      end
    end

    context 'when the postcode checker raises an error' do
      before do
        allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:courts_for).and_raise("expected exception for testing, please ignore")
      end
      it { is_expected.to have_destination(:error_but_continue, :show)}
    end

    context 'when the children_postcodes are nil' do
      let(:postcodes){ nil }
      before do
        allow_any_instance_of(C100App::CourtPostcodeChecker).to receive(:courts_for).and_raise("expected exception for testing, please ignore")
      end
      it { is_expected.to have_destination(:error_but_continue, :show)}
    end
  end

  context 'when the step is `parent`' do
    let(:step_params){ {parent: parent} }
    let(:screener_answers) { double('screener_answers', parent: parent) }

    context 'and parent is "yes"' do
      let(:parent){ GenericYesNo::YES }

      before do
        allow(Rails.configuration.x.screener).to receive(:show_email_consent_step).and_return(show_consent)
      end

      context 'and the email consent step is enabled' do
        let(:show_consent) { true }
        it { is_expected.to have_destination(:email_consent, :edit) }
      end

      context 'and the email consent step is disabled' do
        let(:show_consent) { false }
        it { is_expected.to have_destination(:done, :show) }
      end
    end

    context 'and parent is "no"' do
      let(:parent){ GenericYesNo::NO }

      it { is_expected.to have_destination(:parent_exit, :show) }
    end
  end

  context 'when the step is `email_consent`' do
    let(:step_params) { { email_consent: 'anything' } }
    it { is_expected.to have_destination(:done, :show) }
  end
end
