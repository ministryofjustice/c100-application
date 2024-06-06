require 'spec_helper'

module Summary
  describe HtmlSections::ApplicantsDetails do
    let(:c100_application) {
      instance_double(
        C100Application,
        applicants: [applicant]
      )
    }

    let(:applicant) {
      instance_double(Applicant,
        to_param: 'uuid-123',
        full_name: 'Applicant Test',
        has_previous_name: has_previous_name,
        previous_name: previous_name,
        dob: Date.new(2018, 1, 20),
        dob_estimate: nil,
        gender: 'female',
        birthplace: 'birthplace',
        address_unknown: false, # for applicants this can only be `false`
        residence_requirement_met: 'yes',
        residence_history: 'history',
        home_phone: 'home_phone',
        mobile_provided: mobile_provided,
        mobile_phone: mobile_phone,
        mobile_not_provided_reason: mobile_not_provided_reason,
        email_provided: 'yes',
        email: 'email',
        voicemail_consent: 'yes',
        relationships: [relationship],
        privacy_known: 'yes',
        refuge: 'yes',
        are_contact_details_private: are_contact_details_private,
        contact_details_private: contact_details_private,
        type: 'Applicant'
      )
    }

    let(:mobile_phone) { 'mobile_phone' }
    let(:mobile_provided) { 'yes' }
    let(:mobile_not_provided_reason) { nil }
    let(:are_contact_details_private) { 'yes' }
    let(:contact_details_private) { ['email', 'address', 'home_phone', 'mobile'] }

    before do
      allow(ConfidentialOption).to receive(:changes_apply?).and_return(true)
      allow(applicant).to receive(:full_address).and_return('full address')
      allow(relationship).to receive(:person).and_return(applicant)
      allow(applicant).to receive(:email_private?).and_return(contact_details_private.include?('email'))
      allow(applicant).to receive(:mobile_private?).and_return(contact_details_private.include?('mobile'))
      allow(applicant).to receive(:home_phone_private?).and_return(contact_details_private.include?('home_phone'))
      allow(applicant).to receive(:address_private?).and_return(contact_details_private.include?('address'))
    end

    subject { described_class.new(c100_application) }

    let(:has_previous_name) { 'no' }
    let(:previous_name) { nil }

    let(:relationship) {
      instance_double(
        Relationship,
        relation: 'mother',
        relation_other_value: nil,
        minor: child,
        parental_responsibility: nil,
      )
    }
    let(:child) { instance_double(Child, to_param: 'uuid-555', full_name: 'Child Test') }

    let(:answers) { subject.answers }

    describe '#name' do
      it { expect(subject.name).to eq(:applicants_details) }
    end

    describe '#record_collection' do
      it {
        expect(c100_application).to receive(:applicants)
        subject.record_collection
      }
    end

    # The following tests can be fragile, but on purpose. During the development phase
    # we have to update the tests each time we introduce a new row or remove another.
    # But once it is finished and stable, it will raise a red flag if it ever gets out
    # of sync, which means a quite solid safety net for any maintainers in the future.
    #
    describe '#answers' do
      it 'has the correct number of rows' do
        expect(answers.count).to eq(9)
      end

      it 'has the correct rows in the right order' do
        expect(answers[0]).to be_an_instance_of(Separator)
        expect(answers[0].title).to eq('applicants_details_index_title')
        expect(answers[0].i18n_opts).to eq({index: 1})

        expect(answers[1]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[1].question).to eq(:person_full_name)
        expect(answers[1].change_path).to eq('/steps/applicant/names/')
        expect(answers[1].value).to eq('Applicant Test')

        expect(answers[2]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[2].question).to eq(:person_privacy_known)
        expect(answers[2].change_path).to eq('/steps/applicant/privacy_known/uuid-123')
        expect(answers[2].value).to eq('Yes')

        expect(answers[3]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[3].question).to eq(:person_contact_details_private)
        expect(answers[3].change_path).to eq('/steps/applicant/privacy_preferences/uuid-123')
        expect(answers[3].value).to eq('Email, Current address, Home phone number, Mobile phone number')

        expect(answers[4]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[4].question).to eq(:refuge)
        expect(answers[4].change_path).to eq('/steps/applicant/refuge/uuid-123')
        expect(answers[4].value).to eq('Yes')

        expect(answers[5]).to be_an_instance_of(AnswersGroup)
        expect(answers[5].name).to eq(:person_personal_details)
        expect(answers[5].change_path).to eq('/steps/applicant/personal_details/uuid-123')
        expect(answers[5].answers.count).to eq(4)

          # personal_details group answers ###
          details = answers[5].answers

          expect(details[0]).to be_an_instance_of(Answer)
          expect(details[0].question).to eq(:person_previous_name)
          expect(details[0].value).to eq('no')

          expect(details[1]).to be_an_instance_of(Answer)
          expect(details[1].question).to eq(:person_sex)
          expect(details[1].value).to eq('female')

          expect(details[2]).to be_an_instance_of(DateAnswer)
          expect(details[2].question).to eq(:person_dob)
          expect(details[2].value).to eq(Date.new(2018, 1, 20))

          expect(details[3]).to be_an_instance_of(FreeTextAnswer)
          expect(details[3].question).to eq(:person_birthplace)
          expect(details[3].value).to eq('birthplace')

          expect(answers[6]).to be_an_instance_of(AnswersGroup)
          expect(answers[6].name).to eq(:person_address_details)
          expect(answers[6].change_path).to eq('/steps/applicant/address_details/uuid-123')

          expect(answers[6].answers.count).to eq(4)

          # personal_details group answers ###
          details = answers[6].answers

          expect(details[0]).to be_an_instance_of(FreeTextAnswer)
          expect(details[0].question).to eq(:person_address)
          expect(details[0].value).to eq('full address')

          expect(details[1]).to be_an_instance_of(Answer)
          expect(details[1].question).to eq(:person_residence_requirement_met)
          expect(details[1].value).to eq('yes')

          expect(details[2]).to be_an_instance_of(Answer)
          expect(details[2].question).to eq(:residence_keep_private)
          expect(details[2].value).to eq('yes')

          expect(details[3]).to be_an_instance_of(FreeTextAnswer)
          expect(details[3].question).to eq(:person_residence_history)
          expect(details[3].value).to eq('history')


        expect(answers[7]).to be_an_instance_of(AnswersGroup)
        expect(answers[7].name).to eq(:person_contact_details)
        expect(answers[7].change_path).to eq('/steps/applicant/contact_details/uuid-123')
        expect(answers[7].answers.count).to eq(8)

          # contact details group answers ###
          details = answers[7].answers

          expect(details[0]).to be_an_instance_of(Answer)
          expect(details[0].question).to eq(:person_email_provided)
          expect(details[0].value).to eq('yes')

          expect(details[1]).to be_an_instance_of(FreeTextAnswer)
          expect(details[1].question).to eq(:person_email)
          expect(details[1].value).to eq('email')

          expect(details[2]).to be_an_instance_of(Answer)
          expect(details[2].question).to eq(:email_keep_private)
          expect(details[2].value).to eq('yes')

          expect(details[3]).to be_an_instance_of(FreeTextAnswer)
          expect(details[3].question).to eq(:person_home_phone)
          expect(details[3].value).to eq('home_phone')

          expect(details[4]).to be_an_instance_of(Answer)
          expect(details[4].question).to eq(:phone_keep_private)
          expect(details[4].value).to eq('yes')

          expect(details[5]).to be_an_instance_of(FreeTextAnswer)
          expect(details[5].question).to eq(:person_mobile_phone)
          expect(details[5].value).to eq('mobile_phone')

          expect(details[6]).to be_an_instance_of(Answer)
          expect(details[6].question).to eq(:mobile_keep_private)
          expect(details[6].value).to eq('yes')

          expect(details[7]).to be_an_instance_of(Answer)
          expect(details[7].question).to eq(:person_voicemail_consent)
          expect(details[7].value).to eq('yes')

        expect(answers[8]).to be_an_instance_of(Answer)
        expect(answers[8].question).to eq(:relationship_to_child)
        expect(answers[8].change_path).to eq('/steps/applicant/relationship/uuid-123/child/uuid-555')
        expect(answers[8].value).to eq('mother')
        expect(answers[8].i18n_opts).to eq({child_name: 'Child Test'})

      end

      context 'when mobile phone' do
        context 'has not selected whether to give or not' do
          let(:mobile_phone) { 'mobile_phone' }
          let(:mobile_provided) { nil }
          let(:mobile_not_provided_reason) { nil }

          it 'shows the phone number' do
            expect(answers[7].answers[5].value).to eq('mobile_phone')
          end
        end
        context 'is given' do
          let(:mobile_phone) { 'mobile_phone' }
          let(:mobile_provided) { 'yes' }
          let(:mobile_not_provided_reason) { nil }

          it 'shows the phone number' do
            expect(answers[7].answers[5].value).to eq('mobile_phone')
          end
        end
        context 'is not given with a reason' do
          let(:mobile_phone) { nil }
          let(:mobile_provided) { 'no' }
          let(:mobile_not_provided_reason) { 'no phone' }

          it 'shows the reason' do
            expect(answers[7].answers[5].value).to eq('no phone')
          end
        end
      end

      context 'for existing previous name' do
        let(:has_previous_name) { 'yes' }
        let(:previous_name) { 'previous_name' }

        it 'has the correct number of rows' do
          expect(answers.count).to eq(9)
        end

        it 'renders the previous name' do
          expect(answers[5]).to be_an_instance_of(AnswersGroup)

          details = answers[5].answers
          expect(details[0]).to be_an_instance_of(FreeTextAnswer)
          expect(details[0].question).to eq(:person_previous_name)
          expect(details[0].value).to eq('previous_name')
        end
      end

      context 'for `other` children relationship' do
        let(:relationship) {
          instance_double(
            Relationship,
            relation: 'other',
            relation_other_value: 'Aunt',
            minor: child,
            parental_responsibility: nil,
          )
        }

        it 'has the correct number of rows' do
          expect(answers.count).to eq(9)
        end

        it 'renders the correct relationship value' do
          expect(answers[8]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[8].question).to eq(:relationship_to_child)
          expect(answers[8].change_path).to eq('/steps/applicant/relationship/uuid-123/child/uuid-555')
          expect(answers[8].value).to eq('Aunt')
          expect(answers[8].i18n_opts).to eq({child_name: 'Child Test'})
        end
      end

      context 'when contact details are not kept private' do
        let(:are_contact_details_private) { 'no' }

        it 'renders the correct contact details preferences' do
          expect(answers[3]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[3].question).to eq(:person_contact_details_private)
          expect(answers[3].change_path).to eq('/steps/applicant/privacy_preferences/uuid-123')
          expect(answers[3].value).to eq('No')
        end

      end

      context 'for a children relationship with permission questions answered' do
        let(:relationship) {
          instance_double(Relationship,
            to_param: 'uuid-123',
            relation: 'other',
            relation_other_value: 'Aunt',
            minor: child,
            parental_responsibility: 'no',
            living_order: 'yes',
            # nil values will not show
            amendment: nil,
            time_order: nil,
            living_arrangement: nil,
            consent: nil,
            family: nil,
            local_authority: nil,
            relative: nil,
          )
        }

        before do
          allow(relationship).to receive(:person).and_return(applicant)
        end

        it 'has the correct number of rows' do
          expect(answers.count).to eq(11)
        end

        it 'renders the correct permission values' do
          expect(answers[9]).to be_an_instance_of(Answer)
          expect(answers[9].question).to eq('child_permission_parental_responsibility')
          expect(answers[9].change_path).to eq('/steps/permission/parental_responsibility/relationship/uuid-123')
          expect(answers[9].value).to eq('no')
          expect(answers[9].i18n_opts).to eq({ applicant_name: 'Applicant Test', child_name: 'Child Test'})

          expect(answers[10]).to be_an_instance_of(Answer)
          expect(answers[10].question).to eq('child_permission_living_order')
          expect(answers[10].change_path).to eq('/steps/permission/living_order/relationship/uuid-123')
          expect(answers[10].value).to eq('yes')
          expect(answers[10].i18n_opts).to eq({ applicant_name: 'Applicant Test', child_name: 'Child Test'})
        end
      end
    end
  end
end
