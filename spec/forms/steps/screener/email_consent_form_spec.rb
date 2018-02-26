require 'spec_helper'

RSpec.describe Steps::Screener::EmailConsentForm do
  let(:email_consent){ GenericYesNo::NO }
  let(:email_address){ 'my.email@example.com' }
  let(:arguments) { {
    c100_application: c100_application,
    email_consent: email_consent,
    email_address: email_address
  } }

  let(:c100_application){ instance_double(C100Application) }

  subject { described_class.new(arguments) }

  describe '#save' do
    context 'validations' do
      it { should validate_presence_of(:email_consent, :inclusion) }
      context 'when email_consent is yes' do
        let(:email_consent){ GenericYesNo::YES }
        it { should validate_presence_of(:email_address) }
      end
      context 'when email_consent is no' do
        let(:email_consent){ GenericYesNo::NO }
        it { should_not validate_presence_of(:email_address) }
      end
    end
    it_behaves_like 'a has-one-association form',
                    association_name: :screener_answers,
                    expected_attributes: {
                      email_consent: GenericYesNo::NO,
                      email_address: 'my.email@example.com'
                    }

  end
end
