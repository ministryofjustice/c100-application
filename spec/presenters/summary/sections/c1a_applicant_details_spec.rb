require 'spec_helper'

module Summary
  describe Sections::C1aApplicantDetails do
    let(:c100_application) {
      instance_double(
        C100Application,
        confidentiality_enabled?: confidentiality_enabled?,
        applicants: [applicant]
      )
    }

    let(:applicant) {
      instance_double(Applicant,
        full_name: 'fullname',
        gender: 'female',
        phone_number_provided: phone_number_provided,
        phone_number_not_provided_reason: phone_number_not_provided_reason,
        are_contact_details_private: are_contact_details_private,
        phone_number: 'phone_number',
        email: 'email',
        voicemail_consent: 'yes',
      )
    }

    let(:phone_number_provided) { nil }
    let(:phone_number_not_provided_reason) { nil }
    let(:confidentiality_enabled?) { nil }
    let(:are_contact_details_private) { nil }

    subject { described_class.new(c100_application) }

    let(:answers) { subject.answers }

    describe '#name' do
      it { expect(subject.name).to eq(:c1a_applicant_details) }
    end

    describe '#show_header?' do
      it { expect(subject.show_header?).to eq(false) }
    end

    # The following tests can be fragile, but on purpose. During the development phase
    # we have to update the tests each time we introduce a new row or remove another.
    # But once it is finished and stable, it will raise a red flag if it ever gets out
    # of sync, which means a quite solid safety net for any maintainers in the future.
    #
    describe '#answers' do
      before do
        allow(c100_application).to receive(:confidentiality_enabled?).and_return(false)
      end

      it 'has the correct number of rows' do
        expect(answers.count).to eq(10)
      end

      it 'has the correct rows in the right order' do
        expect(answers[0]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[0].question).to eq(:c1a_full_name)
        expect(answers[0].value).to eq('fullname')

        expect(answers[1]).to be_an_instance_of(Answer)
        expect(answers[1].question).to eq(:person_sex)
        expect(answers[1].value).to eq('female')

        expect(answers[2]).to be_an_instance_of(Answer)
        expect(answers[2].question).to eq(:c1a_person_type)
        expect(answers[2].value).to eq(:applicant)

        expect(answers[3]).to be_an_instance_of(Partial)
        expect(answers[3].name).to eq(:row_blank_space)

        expect(answers[4]).to be_an_instance_of(Separator)
        expect(answers[4].title).to eq(:contact_details)

        expect(answers[5]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[5].question).to eq(:person_email)
        expect(answers[5].value).to eq('email')

        expect(answers[6]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[6].question).to eq(:person_phone_number)
        expect(answers[6].value).to eq('phone_number')

        expect(answers[7]).to be_an_instance_of(Answer)
        expect(answers[7].question).to eq(:person_voicemail_consent)
        expect(answers[7].value).to eq('yes')

        expect(answers[8]).to be_an_instance_of(Partial)
        expect(answers[8].name).to eq(:row_blank_space)

        expect(answers[9]).to be_an_instance_of(Answer)
        expect(answers[9].question).to eq(:c1a_address_confidentiality)
        expect(answers[9].value).to eq(GenericYesNo::NO)
      end


      context "when no phone number and a reason given" do
        let(:phone_number_not_provided_reason) { "No phone" }
        let(:phone_number_provided) { 'no' }
        it "shows the reason" do
          expect(answers[6].value).to eq('No phone')
        end
      end

      context 'when no applicant present' do
        let(:applicant) { nil }

        it 'has the correct number of rows' do
          expect(answers.count).to eq(0)
        end
      end

      context 'when confidentiality is enabled' do
        let(:confidentiality_enabled?) { true }
        let(:are_contact_details_private) { 'yes' }
        let(:contact_details_private) { ['email', 'address', 'phone_number'] }
        let(:applicant) {
          instance_double(Applicant,
            full_name: 'fullname',
            gender: 'female',
            phone_number_provided: 'yes',
            phone_number: 'phone_number',
            email: 'email',
            voicemail_consent: 'yes',
            are_contact_details_private: are_contact_details_private,
            contact_details_private: contact_details_private
          )
        }

        before do
          allow(c100_application).to receive(:confidentiality_enabled?).and_return(true)
        end

        it 'has the correct number of rows' do
          expect(answers.count).to eq(10)
        end

        it 'hides the contact details' do
          expect(answers[5]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[5].question).to eq(:person_email)
          expect(answers[5].value).to eq('[See C8]')

          expect(answers[6]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[6].question).to eq(:person_phone_number)
          expect(answers[6].value).to eq('[See C8]')

          expect(answers[7]).to be_an_instance_of(Answer)
          expect(answers[7].question).to eq(:person_voicemail_consent)
          expect(answers[7].value).to eq('yes')

          expect(answers[9]).to be_an_instance_of(Answer)
          expect(answers[9].question).to eq(:c1a_address_confidentiality)
          expect(answers[9].value).to eq('yes')
        end
      end
    end
  end
end
