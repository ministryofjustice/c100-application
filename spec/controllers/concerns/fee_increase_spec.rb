require 'rails_helper'

RSpec.describe FeeIncrease do

  before(:all) do
    @original_fee_date = Rails.application.config.fee_increase_date
  end

  before do
    allow(ENV).to receive(:[])
    allow(ENV).to receive(:fetch).with('FEE_INCREASE_DATE', "08/04/2025").and_return("08/04/2025")
  end

  after do
    Rails.application.config.fee_increase_date = @original_fee_date
  end

  context 'when date is before fee increase date' do
    before do
      allow(Time).to receive(:now).and_return("07/04/2025")
    end

    describe '#changes_apply?' do
      it { expect(FeeIncrease.changes_apply?).to eq false }
    end
  end

  context 'when date is after fee increase date' do
    before do
      allow(Time).to receive(:now).and_return("08/04/2025")
    end

    describe '#changes_apply?' do
      it { expect(FeeIncrease.changes_apply?).to eq true }
    end
  end
end