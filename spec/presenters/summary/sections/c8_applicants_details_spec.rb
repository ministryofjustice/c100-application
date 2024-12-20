require 'spec_helper'

module Summary
  describe Sections::C8ApplicantsDetails do
    let(:c100_application) {
      instance_double(
        C100Application,
        applicants: [applicant],
        confidentiality_enabled?: 'yes'
      )
    }

    let(:applicant) {
      instance_double(Applicant,
                      full_name: 'fullname',
                      residence_history: 'history',
                      home_phone: 'home_phone',
                      mobile_provided: mobile_provided,
                      mobile_not_provided_reason: mobile_not_provided_reason,
                      mobile_phone: 'mobile_phone',
                      email: 'email',
                      voicemail_consent: 'yes',
                      contact_details_private: contact_details_private
      )
    }

    let(:mobile_provided) { nil }
    let(:mobile_not_provided_reason) { nil }

    let(:contact_details_private) { ['email', 'address', 'home_phone', 'mobile'] }

    before do
      allow(PrivacyChange).to receive(:changes_apply?).and_return(true)
      allow(applicant).to receive(:full_address).and_return('full address')
      allow(applicant).to receive(:email_private?).and_return(contact_details_private.include?('email'))
      allow(applicant).to receive(:mobile_private?).and_return(contact_details_private.include?('mobile'))
      allow(applicant).to receive(:home_phone_private?).and_return(contact_details_private.include?('home_phone'))
      allow(applicant).to receive(:address_private?).and_return(contact_details_private.include?('address'))
      allow(applicant).to receive(:refuge).and_return('yes')
    end

    subject { described_class.new(c100_application) }

    let(:answers) { subject.answers }

    describe '#name' do
      it { expect(subject.name).to eq(:c8_applicants_details) }
    end

    describe '#show_header?' do
      it { expect(subject.show_header?).to eq(true) }
    end

    describe '#record_collection' do
      it {
        expect(c100_application).to receive(:applicants)
        subject.record_collection
      }
    end

    describe '#answers' do
      it 'has the correct number of rows' do
        expect(answers.count).to eq(11)
      end

      it 'has the correct rows in the right order' do
        expect(answers[0]).to be_an_instance_of(Separator)
        expect(answers[0].title).to eq('c8_applicants_details_index_title')
        expect(answers[0].i18n_opts).to eq({index: 1})

        expect(answers[1]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[1].question).to eq(:person_full_name)
        expect(answers[1].value).to eq('fullname')

        expect(answers[2]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[2].question).to eq(:person_address)
        expect(answers[2].value).to eq('full address')

        expect(answers[3]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[3].question).to eq(:person_email)
        expect(answers[3].value).to eq('email')

        expect(answers[4]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[4].question).to eq(:person_home_phone)
        expect(answers[4].value).to eq('home_phone')

        expect(answers[5]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[5].question).to eq(:person_mobile_phone)
        expect(answers[5].value).to eq('mobile_phone')

        expect(answers[6]).to be_an_instance_of(Answer)
        expect(answers[6].question).to eq(:person_voicemail_consent)
        expect(answers[6].value).to eq('yes')

        expect(answers[7]).to be_an_instance_of(Answer)
        expect(answers[7].question).to eq(:refuge)
        expect(answers[7].value).to eq('yes')

        expect(answers[8]).to be_an_instance_of(Partial)
        expect(answers[8].name).to eq(:row_blank_space)

        expect(answers[9]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[9].question).to eq(:person_residence_history)
        expect(answers[9].value).to eq('history')

        expect(answers[10]).to be_an_instance_of(Partial)
        expect(answers[10].name).to eq(:row_blank_space)
      end

      it 'marks all private contact details correctly' do
        expect(applicant.email_private?).to be(true)
        expect(applicant.home_phone_private?).to be(true)
        expect(applicant.mobile_private?).to be(true)
        expect(applicant.address_private?).to be(true)
      end

      context "when no mobile and a reason given" do
        before do
          allow(applicant).to receive(:refuge).and_return('no')
        end

        let(:mobile_not_provided_reason) { "No phone" }
        let(:mobile_provided) { 'no' }

        it "shows the reason" do
          expect(answers[5].value).to eq('No phone')
        end
      end

      context 'only one marked as private' do
        before do
          allow(applicant).to receive(:refuge).and_return('no')
        end

        let(:applicant) {
          instance_double(Applicant,
                          full_name: 'fullname',
                          residence_history: 'history',
                          home_phone: 'home_phone',
                          mobile_phone: 'mobile_phone',
                          email: 'email',
                          voicemail_consent: 'yes',
                          contact_details_private: contact_details_private
          )
        }
        let(:contact_details_private) { [] }
        it 'has the correct number of rows' do
          expect(answers.count).to eq(0)
        end
      end

      context 'when refuge is no, only selected private details should be private' do
        let(:contact_details_private) { ['email', 'home_phone'] }

        before do
          allow(applicant).to receive(:refuge).and_return('no')
        end

        it 'marks only the selected private details as private' do
          expect(applicant.email_private?).to be(true)
          expect(applicant.home_phone_private?).to be(true)
          expect(applicant.mobile_private?).to be(false)
          expect(applicant.address_private?).to be(false)
        end

        it 'has the correct number of rows' do
          expect(answers.count).to eq(8)
        end

        it 'returns the correct content for answers' do
          expect(answers[0]).to be_an_instance_of(Separator)
          expect(answers[0].title).to eq('c8_applicants_details_index_title')
          expect(answers[0].i18n_opts).to eq({index: 1})

          expect(answers[1]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[1].question).to eq(:person_full_name)
          expect(answers[1].value).to eq('fullname')

          expect(answers[2]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[2].question).to eq(:person_email)
          expect(answers[2].value).to eq('email')

          expect(answers[3]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[3].question).to eq(:person_home_phone)
          expect(answers[3].value).to eq('home_phone')

          expect(answers[4]).to be_an_instance_of(Answer)
          expect(answers[4].question).to eq(:person_voicemail_consent)
          expect(answers[4].value).to eq('yes')

          expect(answers[5]).to be_an_instance_of(Answer)
          expect(answers[5].question).to eq(:refuge)
          expect(answers[5].value).to eq('no')

          expect(answers[6]).to be_an_instance_of(Partial)
          expect(answers[6].name).to eq(:row_blank_space)

          expect(answers[7]).to be_an_instance_of(Partial)
          expect(answers[7].name).to eq(:row_blank_space)
        end
      end
    end
  end
end
