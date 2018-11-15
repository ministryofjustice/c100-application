require 'rails_helper'

RSpec.describe CompletedApplicationsAudit, type: :model do
  let(:c100_application) {
    C100Application.new(
      id: '449362af-0bc3-4953-82a7-1363d479b876',
      created_at: Time.at(0),
      updated_at: Time.at(100),
      urgent_hearing: 'no',
      without_notice: 'yes',
      submission_type: 'online',
      payment_type: 'cash',
    )
  }

  let(:user_id) { nil }
  let(:screener_answers_court) { instance_double(Court, name: 'Test Court') }
  let(:screener_answers) { instance_double(ScreenerAnswers, children_postcodes: 'abcd 123') }

  before do
    allow(c100_application).to receive(:user_id).and_return(user_id)
    allow(c100_application).to receive(:screener_answers).and_return(screener_answers)
    allow(c100_application).to receive(:screener_answers_court).and_return(screener_answers_court)
  end

  describe 'db table name' do
    it { expect(described_class.table_name).to eq('completed_applications_audit') }
  end

  describe 'db table primary key' do
    it { expect(described_class.primary_key).to eq('reference_code') }
  end

  describe '.log!' do
    it 'creates a record with the expected information' do
      expect(
        described_class
      ).to receive(:create).with(
        started_at: Time.at(0),
        completed_at: Time.at(100),
        reference_code: '1970/01/449362AF',
        submission_type: 'online',
        court: 'Test Court',
        metadata: {
          postcode: 'ABCD1**',
          c1a_form: false,
          c8_form: false,
          saved_for_later: false,
          urgent_hearing: 'no',
          without_notice: 'yes',
          payment_type: 'cash',
        }
      )

      described_class.log!(c100_application)
    end

    context 'for a saved application' do
      let(:user_id) { 123 }

      it 'creates a record with the expected information' do
        expect(
          described_class
        ).to receive(:create).with(
          hash_including(metadata: hash_including(saved_for_later: true))
        )

        described_class.log!(c100_application)
      end
    end
  end
end
