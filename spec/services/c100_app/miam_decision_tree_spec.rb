require 'rails_helper'

RSpec.describe C100App::MiamDecisionTree do
  let(:c100_application) { double('Object') }
  let(:step_params)      { double('Step') }
  let(:next_step)        { nil }
  let(:as)               { nil }

  let(:c100_application) { instance_double(C100Application) }

  subject { described_class.new(c100_application: c100_application, step_params: step_params, as: as, next_step: next_step) }

  it_behaves_like 'a decision tree'

  context 'when the step is `miam_acknowledgement`' do
    let(:step_params) { { miam_acknowledgement: 'anything' } }
    it { is_expected.to have_destination(:attended, :edit) }
  end

  context 'when the step is `miam_attended`' do
    let(:c100_application) { instance_double(C100Application, miam_attended: value) }
    let(:step_params) { { miam_attended: 'anything' } }

    context 'and the answer is `yes`' do
      let(:value) { 'yes' }
      it { is_expected.to have_destination(:certification, :edit) }
    end

    context 'and the answer is `no`' do
      let(:value) { 'no' }
      it { is_expected.to have_destination(:not_attended_info, :show) }
    end
  end

  context 'when the step is `miam_certification`' do
    let(:c100_application) { instance_double(C100Application, miam_certification: value) }
    let(:step_params) { { miam_certification: 'anything' } }

    context 'and the answer is `yes`' do
      let(:value) { 'yes' }
      it { is_expected.to have_destination('/steps/applicant/number_of_children', :edit) }
    end

    context 'and the answer is `no`' do
      let(:value) { 'no' }
      it { is_expected.to have_destination(:no_certification_kickout, :show) }
    end
  end
end
