require 'spec_helper'

RSpec.describe Steps::Solicitor::ContactDetailsForm do
  let(:arguments) { {
    c100_application: c100_application,
    email: email,
    phone_number: phone_number,
    fax_number: fax_number,
    dx_number: dx_number,
    email_provided: email_provided,
  } }

  let(:email_provided) { 'yes' }
  let(:email) { 'test@example.com' }
  let(:phone_number) { '01234123123' }
  let(:fax_number) { '01234123123' }
  let(:dx_number) { '123-123' }

  let(:c100_application) { instance_double(C100Application) }

  subject { described_class.new(arguments) }

  describe '#save' do
    context 'validations' do
      it { should validate_presence_of(:email) }
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
      end

      context 'phone validation' do
        context 'phone is invalid' do
          let(:phone_number) { 'xxx' }

          it {
            expect(subject).not_to be_valid
            expect(subject.errors.added?(:phone_number, :invalid)).to eq(true)
          }
        end
      end

      context 'fax validation' do
        context 'fax is invalid' do
          let(:fax_number) { 'xxx' }

          it {
            expect(subject).not_to be_valid
            expect(subject.errors.added?(:fax_number, :invalid)).to eq(true)
          }
        end
      end

      context 'dx validation' do
        context 'dx is invalid' do
          let(:dx_number) { 'xxx' }

          it {
            expect(subject).not_to be_valid
            expect(subject.errors.added?(:dx_number, :invalid)).to eq(true)
          }
        end
      end
    end

    it_behaves_like 'a has-one-association form',
                    association_name: :solicitor,
                    expected_attributes: {
                      email: 'test@example.com',
                      phone_number: '01234123123',
                      fax_number: '01234123123',
                      dx_number: '123-123',
                      email_provided: GenericYesNo.new('yes'),
                    }
  end
end
