require 'rails_helper'

RSpec.describe C100App::AttendingCourtDecisionTree do
  let(:c100_application) { double('Object') }
  let(:step_params)      { double('Step') }
  let(:next_step)        { nil }
  let(:as)               { nil }

  subject { described_class.new(c100_application: c100_application, step_params: step_params, as: as, next_step: next_step) }

  it_behaves_like 'a decision tree'

  context 'when the step is `language`' do
    let(:step_params) { { language: 'anything' } }
    it { is_expected.to have_destination(:intermediary, :edit) }
  end

  context 'when the step is `intermediary`' do
    let(:step_params) { { intermediary: 'anything' } }
    it { is_expected.to have_destination('/steps/application/special_arrangements', :edit) }
  end
end
