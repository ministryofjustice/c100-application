require 'rails_helper'

RSpec.describe RemoveRespondentPrivacyHelper, type: :helper do
  let(:respondent) { double('Respondent') }
  let(:respondents) { [respondent] }

  let(:c100_application) do
    instance_double(C100Application, respondents: respondents)
  end

  describe "#remove_privacy_if_single_respondent" do
    context "when there is only one respondent" do
      before do
        allow(respondent).to receive(:update)
      end

      it "clears the respondent privacy setting" do
        expect(respondent).to receive(:update).with(
          are_contact_details_private: nil
        )

        helper.remove_privacy_if_single_respondent(c100_application)
      end
    end

    context "when there are multiple respondents" do
      let(:respondents) { [respondent, double('Respondent')] }

      it "does not update any respondent" do
        expect(respondent).not_to receive(:update)

        helper.remove_privacy_if_single_respondent(c100_application)
      end
    end

    context "when there are no respondents" do
      let(:respondents) { [] }

      it "does not update anything" do
        expect(respondent).not_to receive(:update)

        helper.remove_privacy_if_single_respondent(c100_application)
      end
    end
  end
end