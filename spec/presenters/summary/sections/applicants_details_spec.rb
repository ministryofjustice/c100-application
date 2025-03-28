require 'spec_helper'

module Summary
  describe Sections::ApplicantsDetails do
    let(:c100_application) {
      instance_double(
        C100Application,
        confidentiality_enabled?: false,
        applicants: [applicant]
      )
    }

    let(:applicant) {
      instance_double(Applicant,
        full_name: 'fullname',
        has_previous_name: has_previous_name,
        previous_name: previous_name,
        dob: Date.new(2018, 1, 20),
        dob_estimate: nil,
        gender: 'female',
        birthplace: 'birthplace',
        residence_requirement_met: 'yes',
        residence_history: 'history',
        phone_number_provided: phone_number_provided,
        phone_number: phone_number,
        phone_number_not_provided_reason: phone_number_not_provided_reason,
        email: 'email',
        voicemail_consent: 'yes',
        phone_number_unknown: nil,
        email_unknown: nil,
        privacy_known: privacy_known,
        are_contact_details_private: are_contact_details_private,
        contact_details_private: contact_details_private,
        type: 'Applicant',
        refuge: refuge
      )
    }

    let(:contact_details_private) { ['email', 'address', 'phone_number'] }

    before do
      allow(PrivacyChange).to receive(:changes_apply?).and_return(true)
      allow(applicant).to receive(:instance_of?).and_return(Applicant)
      allow(applicant).to receive(:full_address).and_return('full address')
      allow(applicant).to receive(:email_private?).and_return(contact_details_private.include?('email'))
      allow(applicant).to receive(:phone_number_private?).and_return(contact_details_private.include?('phone_number'))
      allow(applicant).to receive(:address_private?).and_return(contact_details_private.include?('address'))
    end

    subject { described_class.new(c100_application) }

    let(:phone_number) { 'phone_number' }
    let(:phone_number_provided) { 'yes' }
    let(:phone_number_not_provided_reason) { nil }

    let(:has_previous_name) { 'no' }
    let(:previous_name) { nil }
    let(:privacy_known) { 'no' }
    let(:are_contact_details_private) { 'no' }
    let(:refuge) { nil }

    let(:answers) { subject.answers }

    describe '#name' do
      it { expect(subject.name).to eq(:applicants_details) }
    end

    describe '#show_header?' do
      it { expect(subject.show_header?).to eq(false) }
    end

    describe '#record_collection' do
      it {
        expect(c100_application).to receive(:applicants)
        subject.record_collection
      }

      it {
        expect(subject.record_collection).to be_an_instance_of(C8CollectionProxy)
      }
    end

    # The following tests can be fragile, but on purpose. During the development phase
    # we have to update the tests each time we introduce a new row or remove another.
    # But once it is finished and stable, it will raise a red flag if it ever gets out
    # of sync, which means a quite solid safety net for any maintainers in the future.
    #
    describe '#answers' do
      before do
        allow_any_instance_of(
          RelationshipsPresenter
        ).to receive(:relationship_to_children).with(
          applicant, show_person_name: false
        ).and_return('relationships')
      end

      it 'has the correct number of rows' do
        expect(answers.count).to eq(16)
      end

      it 'has the correct rows in the right order' do
        expect(answers[0]).to be_an_instance_of(Separator)
        expect(answers[0].title).to eq('applicants_details_index_title')
        expect(answers[0].i18n_opts).to eq({index: 1})

        expect(answers[1]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[1].question).to eq(:person_full_name)
        expect(answers[1].value).to eq('fullname')

        expect(answers[2]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[2].question).to eq(:person_privacy_known)
        expect(answers[2].value).to eq('No')

        expect(answers[3]).to be_an_instance_of(Partial)
        expect(answers[3].name).to eq(:privacy_preferences)
        expect(answers[3].ivar).to eq({
          are_contact_details_private: 'no',
          contact_details_private: contact_details_private
        })

        expect(answers[4]).to be_an_instance_of(Answer)
        expect(answers[4].question).to eq(:person_previous_name)
        expect(answers[4].value).to eq('no')

        expect(answers[5]).to be_an_instance_of(Answer)
        expect(answers[5].question).to eq(:person_sex)
        expect(answers[5].value).to eq('female')

        expect(answers[6]).to be_an_instance_of(DateAnswer)
        expect(answers[6].question).to eq(:person_dob)
        expect(answers[6].value).to eq(Date.new(2018, 1, 20))

        expect(answers[7]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[7].question).to eq(:person_birthplace)
        expect(answers[7].value).to eq('birthplace')

        expect(answers[8]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[8].question).to eq(:person_address)
        expect(answers[8].value).to eq('full address')

        expect(answers[9]).to be_an_instance_of(Answer)
        expect(answers[9].question).to eq(:person_residence_requirement_met)
        expect(answers[9].value).to eq('yes')

        expect(answers[10]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[10].question).to eq(:person_residence_history)
        expect(answers[10].value).to eq('history')

        expect(answers[11]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[11].question).to eq(:person_email)
        expect(answers[11].value).to eq('email')

        expect(answers[12]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[12].question).to eq(:person_phone_number)
        expect(answers[12].value).to eq('phone_number')

        expect(answers[13]).to be_an_instance_of(Answer)
        expect(answers[13].question).to eq(:person_voicemail_consent)
        expect(answers[13].value).to eq('yes')

        expect(answers[14]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[14].question).to eq(:person_relationship_to_children)
        expect(answers[14].value).to eq('relationships')

        expect(answers[15]).to be_an_instance_of(Partial)
        expect(answers[15].name).to eq(:row_blank_space)
      end


      context 'when phone number' do
        context 'has not selected whether to give or not' do
          let(:phone_number) { 'phone_number' }
          let(:phone_number_provided) { nil }
          let(:phone_number_not_provided_reason) { nil }

          it 'shows the phone number' do
            expect(answers[12].value).to eq('phone_number')
          end
        end
        context 'is given' do
          let(:phone_number) { 'phone_number' }
          let(:phone_number_provided) { 'yes' }
          let(:phone_number_not_provided_reason) { nil }

          it 'shows the phone number' do
            expect(answers[12].value).to eq('phone_number')
          end
        end
        context 'is not given with a reason' do
          let(:phone_number) { nil }
          let(:phone_number_provided) { 'no' }
          let(:phone_number_not_provided_reason) { 'no phone' }

          it 'shows the reason' do
            expect(answers[12].value).to eq('no phone')
          end
        end
      end

      context 'for existing previous name' do
        let(:has_previous_name) { 'yes' }
        let(:previous_name) { 'previous_name' }

        it 'has the correct number of rows' do
          expect(answers.count).to eq(16)
        end

        it 'renders the previous name' do
          expect(answers[4]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[4].question).to eq(:person_previous_name)
          expect(answers[4].value).to eq('previous_name')
        end
      end

      context 'when contact_details_private is not given' do
        let(:privacy_known) { nil }
        let(:are_contact_details_private) { nil }
        let(:contact_details_private) { [] }
        let(:refuge) { nil }

        it 'has the correct number of rows' do
          expect(answers.count).to eq(14)
        end

        it 'renders the previous name' do
          expect(answers[2]).to be_an_instance_of(Answer)
          expect(answers[2].question).to eq(:person_previous_name)
          expect(answers[2].value).to eq('no')
        end
      end


      context 'when contact details kept private' do
        let(:privacy_known) { 'yes' }
        let(:are_contact_details_private) { 'yes' }
        let(:contact_details_private) { ['email', 'address', 'phone_number'] }
        let(:refuge) { 'no' }

        it 'shows as private' do
          expect(answers[2]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[2].question).to eq(:person_privacy_known)
          expect(answers[2].value).to eq('Yes')

          expect(answers[3]).to be_an_instance_of(Partial)
          expect(answers[3].name).to eq(:privacy_preferences)
          expect(answers[3].ivar).to eq({
            are_contact_details_private: 'yes',
            contact_details_private: ['email', 'address', 'phone_number']
          })
        end

        it 'hides the relevant details' do
          expect(answers[8]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[8].question).to eq(:person_address)
          expect(answers[8].value).to eq('[See C8]')

          expect(answers[11]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[11].question).to eq(:person_email)
          expect(answers[11].value).to eq('[See C8]')

          expect(answers[12]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[12].question).to eq(:person_phone_number)
          expect(answers[12].value).to eq('[See C8]')
        end
      end

      context 'when the applicant is in refuge' do
        let(:refuge) { 'yes' }

        it 'shows all contact details as private' do
          expect(answers[8]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[8].question).to eq(:person_address)
          expect(answers[8].value).to eq('[See C8]')

          expect(answers[11]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[11].question).to eq(:person_email)
          expect(answers[11].value).to eq('[See C8]')

          expect(answers[12]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[12].question).to eq(:person_phone_number)
          expect(answers[12].value).to eq('[See C8]')
        end
      end
    end
  end
end
