require 'spec_helper'

RSpec.describe Steps::Solicitor::ContactDetailsForm do
  let(:arguments) { {
    c100_application: c100_application,
    email: email,
    phone_number: 'phone_number',
    fax_number: 'fax_number',
    dx_number: 'dx_number',
    email_provided: email_provided,
  } }

  let(:email_provided) { 'yes' }
  let(:email) { 'test@example.com' }

  let(:c100_application) { instance_double(C100Application) }

  subject { described_class.new(arguments) }

  describe '#save' do
    context 'validations' do
      it { should validate_presence_of(:phone_number) }

      context 'email validation' do
        context 'email is invalid' do
          let(:email) { 'xxx' }

          it {
            expect(subject).not_to be_valid
            expect(subject.errors.added?(:email, :invalid)).to eq(true)
          }
        end

        context 'email domain contains a typo' do
          let(:email) { 'test@gamil.com' }

          it {
            expect(subject).not_to be_valid
            expect(subject.errors.added?(:email, :typo)).to eq(true)
          }
        end

        context 'when email not provided' do
          let(:email) { nil }
          let(:email_provided) { 'no' }
          before { subject.valid? }
          specify { expect(subject).to be_valid }
        end

        context 'when email provided' do
          let(:email) { nil }
          let(:email_provided) { 'yes' }
          before { subject.valid? }
          specify { expect(subject).to_not be_valid }
          specify { expect(subject.errors.details.dig(:email, 0, :error)).to eq(:invalid) }
        end

        %w(bad bad@ bad@domain bad@domain.).each do |malformed_email|
          context "when email set to '#{malformed_email}'" do
            let(:email) { malformed_email }
            before { subject.valid? }
            specify { expect(subject).to_not be_valid }
            specify { expect(subject.errors.details.dig(:email, 0, :error)).to eq(:invalid) }
          end
        end

        context 'when no email provided' do
          let(:email_provided) { 'no' }

          it '#attributes_map resets email' do
            expect(subject.send(:attributes_map)).to include(email: nil)
          end
        end
      end
    end

    it_behaves_like 'a has-one-association form',
                    association_name: :solicitor,
                    expected_attributes: {
                      email: 'test@example.com',
                      phone_number: 'phone_number',
                      fax_number: 'fax_number',
                      dx_number: 'dx_number',
                      email_provided: GenericYesNo.new('yes'),
                    }
  end
end
