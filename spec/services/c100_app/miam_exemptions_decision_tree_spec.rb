require 'rails_helper'

RSpec.describe C100App::MiamExemptionsDecisionTree do
  let(:c100_application) { double('Object') }
  let(:step_params)      { double('Step') }
  let(:next_step)        { nil }
  let(:as)               { nil }

  subject { described_class.new(c100_application: c100_application, step_params: step_params, as: as, next_step: next_step) }

  it_behaves_like 'a decision tree'

  context 'when the step is `domestic`' do
    let(:step_params) { { domestic: 'anything' } }
    it { is_expected.to have_destination(:protection, :edit) }
  end

  context 'when the step is `protection`' do
    let(:step_params) { { protection: 'anything' } }
    it { is_expected.to have_destination(:urgency, :edit) }
  end

  context 'when the step is `urgency`' do
    let(:step_params) { { urgency: 'anything' } }
    it { is_expected.to have_destination(:adr, :edit) }
  end

  context 'when the step is `adr`' do
    let(:step_params) { { adr: 'anything' } }
    it { is_expected.to have_destination(:misc, :edit) }
  end

  context 'when the step is `exemption_details`' do
    let(:step_params) { { exemption_details: 'anything' } }
    it { is_expected.to have_destination(:reasons_playback, :show) }
  end

  context 'when the step is `exemption_upload`' do
    let(:step_params) { { exemption_upload: 'anything' } }
    it { is_expected.to have_destination(:exemption_details, :edit) }
  end

  context 'when the step is `misc` and Mediation change is false' do
    let(:c100_application) { C100Application.new(attributes) }
    let(:step_params) { { misc: 'anything' } }
    let(:attributes) {
      {
        miam_exemption: nil,
      }
    }

    before do
      allow(MediationChange).to receive(:changes_apply?).and_return(false)
    end

    context 'when there are no MIAM exemptions' do
      it { is_expected.to have_destination(:exit_page, :show) }
    end

    context 'when there are MIAM exemptions' do
      let(:attributes) { super().merge(miam_exemption: MiamExemption.new(misc: ['applicant_under_age'])) }

      it { is_expected.to have_destination(:reasons_playback, :show) }
    end
  end

  context 'when the step is `misc` and Mediation change is true' do
    let(:c100_application) { C100Application.new(attributes) }
    let(:step_params) { { misc: 'anything' } }
    let(:attributes) {
      {
        miam_exemption: nil,
      }
    }

    before do
      allow(MediationChange).to receive(:changes_apply?).and_return(true)
    end

    context 'when there are no MIAM exemptions' do
      it { is_expected.to have_destination(:exit_page, :show) }
    end

    context 'when there are MIAM exemptions' do
      describe 'and they are only misc exemptions' do
        let(:attributes) { super().merge(miam_exemption: MiamExemption.new(domestic: ['misc_domestic_none'],
                                                                           protection: ['misc_protection_none'],
                                                                           urgency: ['misc_urgency_none'],
                                                                           adr: ['misc_adr_none'],
                                                                           misc: ['applicant_under_age'])) }

        it { is_expected.to have_destination(:exemption_reasons, :edit) }
      end

      describe 'and they are not only misc exemptions' do
        let(:attributes) { super().merge(miam_exemption: MiamExemption.new(domestic: ['misc_domestic_none'],
                                                                           adr: ['misc_previous_attendance'], misc: ['applicant_under_age'])) }
        it { is_expected.to have_destination(:reasons_playback, :show) }
      end

      describe 'and they have domestic exemptions' do
        let(:attributes) { super().merge(miam_exemption: MiamExemption.new(domestic: ['police_arrested'],
                                                                           adr: ['misc_previous_attendance'], misc: ['applicant_under_age'])) }
        it { is_expected.to have_destination(:exemption_reasons, :edit) }
      end
    end
  end

  context 'when the step is exemption reasons' do
    let(:c100_application) { C100Application.new(attributes) }
    let(:step_params) { { exemption_reasons: 'anything' } }
    let(:attributes) {
      {
        attach_evidence: nil,
      }
    }
    context 'and attach_evidence is not yes' do
      it { is_expected.to have_destination(:exemption_details, :edit) }
    end

    context 'and a MIAM exemption has been selected' do
      let(:attributes) { super().merge(miam_exemption: MiamExemption.new(misc: ['applicant_under_age'])) }

      it { is_expected.to have_destination(:exemption_details, :edit) }
    end

    context 'and attach_evidence is yes' do
      let(:attributes) {
        {
          attach_evidence: 'yes',
        }
      }

      it { is_expected.to have_destination(:exemption_upload, :edit) }

    end
  end
end
