require 'rails_helper'

RSpec.describe MediationChange do

  let(:c100_application) { double(C100Application, created_at: DateTime.parse(created_at)) }
  let(:created_at) { nil }

  before do
    allow(ENV).to receive(:[])
    allow(ENV).to receive(:fetch).with('MEDIATION_DATE', "29/04/2024").and_return("29/04/2024")
  end

  context 'when date is before mediation date' do
    let(:created_at) { "28/04/2024" }

    describe '#changes_apply?' do
      it { expect(MediationChange.changes_apply?(c100_application)).to eq false }
    end
  end

  context 'when date is after mediation date' do
    let(:created_at) { "01/05/2024" }

    describe '#changes_apply?' do
      it { expect(MediationChange.changes_apply?(c100_application)).to eq true }
    end
  end
end