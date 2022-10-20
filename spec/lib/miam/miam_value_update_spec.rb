require 'rails_helper'

RSpec.describe Miam::MiamValueUpdate do
  let(:miam) {MiamExemption.create( adr: %w[previous_attendance ongoing_attendance existing_proceedings_attendance
               previous_exemption existing_proceedings_exemption adr_none],
                                    domestic: %w[right_to_remain financial_abuse domestic_none],
                                    misc: %w[no_respondent_address without_notice access_prohibited
                non_resident applicant_under_age],
                                    protection: %w[authority_enquiring authority_protection_order protection_none],
                                    urgency: %w[risk_applicant unreasonable_hardship risk_children
                   risk_unlawful_removal_retention miscarriage_justice irretrievable_problems
                   international_proceedings urgency_none] )}
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

    expect(miam.domestic).to eq(%w[misc_right_to_remain misc_financial_abuse misc_domestic_none])
    expect(miam.adr).to eq(%w[misc_previous_attendance misc_ongoing_attendance
               misc_existing_proceedings_attendance misc_previous_exemption
               misc_existing_proceedings_exemption misc_adr_none])
    expect(miam.misc).to eq(%w[misc_no_respondent_address misc_without_notice misc_access_prohibited
                misc_non_resident misc_applicant_under_age])
    expect(miam.protection).to eq(%w[misc_authority_enquiring misc_authority_protection_order
                      misc_protection_none])
    expect(miam.urgency).to eq(%w[misc_risk_applicant misc_unreasonable_hardship misc_risk_children
                   misc_risk_unlawful_removal_retention misc_miscarriage_justice
                   misc_irretrievable_problems misc_international_proceedings misc_urgency_none])

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

    expect(miam.domestic).to eq(%w[right_to_remain financial_abuse domestic_none])
    expect(miam.adr).to eq(%w[previous_attendance ongoing_attendance existing_proceedings_attendance previous_exemption
                          existing_proceedings_exemption adr_none])
    expect(miam.misc).to eq(%w[no_respondent_address without_notice access_prohibited non_resident applicant_under_age])
    expect(miam.protection).to eq(%w[authority_enquiring authority_protection_order protection_none])
    expect(miam.urgency).to eq(%w[risk_applicant unreasonable_hardship risk_children risk_unlawful_removal_retention
                              miscarriage_justice irretrievable_problems international_proceedings urgency_none])

    expect(miam2.domestic).to eq(%w[right_to_remain financial_abuse])
    expect(miam2.adr).to eq(%w[adr_none])
    expect(miam2.misc).to eq(%w[misc_none access_prohibited non_resident])
  end
<<<<<<< HEAD
end
=======
end
>>>>>>> merge-new-c100
