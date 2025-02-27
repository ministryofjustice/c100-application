require 'spec_helper'

module Summary
  describe Sections::C8OtherPartiesDetails do
    let(:c100_application) {
      instance_double(
        C100Application,
        other_parties: [other_party],
      )
    }

    let(:other_party) {
      instance_double(OtherParty,
        full_name: 'fullname',
        has_previous_name: has_previous_name,
        previous_name: previous_name,
        dob: dob,
        dob_estimate: dob_estimate,
        gender: 'female',
        refuge: 'yes',
        birthplace: nil,
        residence_requirement_met: nil,
        residence_history: nil,
        phone_number_provided: nil,
        phone_number: nil,
        email: nil,
        phone_number_unknown: nil,
        email_unknown: nil,
        voicemail_consent: nil,
        privacy_known: nil,
        cohabit_with_other: cohabit_with_other,
        are_contact_details_private: are_contact_details_private,
        type: 'OtherParty'
      )
    }

    let(:contact_details_private) { [] }

    before do
      allow(PrivacyChange).to receive(:changes_apply?).and_return(true)
      allow(other_party).to receive(:full_address).and_return('full address')
      allow(other_party).to receive(:refuge).and_return('yes')
      allow(other_party).to receive(:email_private?).and_return(contact_details_private.include?('email'))
      allow(other_party).to receive(:phone_number_private?).and_return(contact_details_private.include?('phone_number'))
      allow(other_party).to receive(:address_private?).and_return(contact_details_private.include?('address'))
    end

    subject { described_class.new(c100_application) }

    let(:has_previous_name) { 'no' }
    let(:previous_name) { nil }
    let(:dob) { Date.new(2018, 1, 20) }
    let(:dob_estimate) { nil }
    let(:cohabit_with_other) { 'yes' }
    let(:are_contact_details_private) { 'yes' }

    let(:answers) { subject.answers }

    describe '#name' do
      it { expect(subject.name).to eq(:c8_other_parties_details) }
    end

    describe '#show_header?' do
      it { expect(subject.show_header?).to eq(true) }
    end

    describe '#record_collection' do
      it {
        expect(c100_application).to receive(:other_parties)
        subject.record_collection
      }
    end

    describe '#answers' do
      before do
        allow_any_instance_of(
          RelationshipsPresenter
        ).to receive(:relationship_to_children).with(
          other_party, show_person_name: false, bypass_c8: true
        ).and_return('relationships')
      end

      it 'has the correct number of rows' do
        expect(answers.count).to eq(10)
      end

      it 'has the correct rows in the right order' do
        expect(answers[0]).to be_an_instance_of(Separator)
        expect(answers[0].title).to eq('c8_other_parties_details_index_title')
        expect(answers[0].i18n_opts).to eq({index: 1})

        expect(answers[1]).to be_an_instance_of(Answer)
        expect(answers[1].question).to eq(:refuge)
        expect(answers[1].value).to eq('yes')

        expect(answers[2]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[2].question).to eq(:person_full_name)
        expect(answers[2].value).to eq('fullname')

        expect(answers[3]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[3].question).to eq(:person_cohabit_other)
        expect(answers[3].value).to eq('Yes')

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
        expect(answers[7].question).to eq(:person_address)
        expect(answers[7].value).to eq('full address')

        expect(answers[8]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[8].question).to eq(:person_relationship_to_children)
        expect(answers[8].value).to eq('relationships')

        expect(answers[9]).to be_an_instance_of(Partial)
        expect(answers[9].name).to eq(:row_blank_space)
      end

      context 'for existing previous name' do
        let(:has_previous_name) { 'yes' }
        let(:previous_name) { 'previous_name' }

        it 'has the correct number of rows' do
          expect(answers.count).to eq(10)
        end

        it 'renders the previous name' do
          expect(answers[4]).to be_an_instance_of(FreeTextAnswer)
          expect(answers[4].question).to eq(:person_previous_name)
          expect(answers[4].value).to eq('previous_name')
        end
      end

      context 'when `dob` is nil' do
        let(:dob) { nil }
        let(:dob_estimate) { Date.today }

        it 'has the correct number of rows' do
          expect(answers.count).to eq(10)
        end

        it 'uses the dob estimate' do
          expect(answers[6]).to be_an_instance_of(DateAnswer)
          expect(answers[6].question).to eq(:person_dob_estimate)
          expect(answers[6].value).to eq(Date.today)
        end
      end

      context 'when confidential is nil and c8 is not needed' do
        let(:are_contact_details_private) { nil }

        it 'has no rows' do
          expect(answers.count).to eq(0)
        end
      end
    end
  end
end
