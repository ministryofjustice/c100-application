require 'rails_helper'

RSpec.describe C100App::Admin::MiamValueUpdate do
  let(:miam) {MiamExemption.create(:domestic => %w[right_to_remain financial_abuse], :adr => %w[previous_exemption],
                                    :urgency => %w[risk_children], :misc => %w[misc_none without_notice])}
  let!(:c100_application) {C100Application.create(miam_exemption: miam)}

  let(:miam2) {MiamExemption.create(:domestic => %w[right_to_remain financial_abuse], :adr => %w[adr_none],
                               :misc => %w[misc_none access_prohibited non_resident])}
  let!(:c100_application2) {C100Application.create(miam_exemption: miam2)}

  after do
    c100_application.destroy
    c100_application2.destroy
    miam.destroy
    miam2.destroy
  end

  it 'converts miam exemptions' do
    subject.update_miam_values!

    miam.reload
    miam2.reload

    expect(miam.domestic).to eq(%w[misc_right_to_remain misc_financial_abuse])
    expect(miam.adr).to eq(%w[misc_previous_exemption])
    expect(miam.urgency).to eq(%w[misc_risk_children])
    expect(miam.misc).to eq(%w[misc_none misc_without_notice])

    expect(miam2.domestic).to eq(%w[misc_right_to_remain misc_financial_abuse])
    expect(miam2.adr).to eq(%w[misc_adr_none])
    expect(miam2.urgency).to eq([])
    expect(miam2.misc).to eq(%w[misc_none misc_access_prohibited misc_non_resident])
  end

  it 'reverts the miam values' do
    subject.update_miam_values!
    subject.undo_miam_migrate!

    miam.reload
    miam2.reload

    expect(miam.domestic).to eq(%w[right_to_remain financial_abuse])
    expect(miam.adr).to eq(%w[previous_exemption])
    expect(miam.urgency).to eq(%w[risk_children])
    expect(miam.misc).to eq(%w[misc_none without_notice])

    expect(miam2.domestic).to eq(%w[right_to_remain financial_abuse])
    expect(miam2.adr).to eq(%w[adr_none])
    expect(miam2.misc).to eq(%w[misc_none access_prohibited non_resident])
  end
end