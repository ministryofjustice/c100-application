require 'spec_helper'

module Summary
  describe Sections::OtherPartiesDetails do
    let(:c100_application) {
      instance_double(
        C100Application,
        other_parties: other_parties,
      )
    }
    let(:other_parties) { [other_party] }
    let(:other_party) {
      instance_double(OtherParty,
        full_name: 'fullname',
        has_previous_name: has_previous_name,
        previous_name: previous_name,
        dob: dob,
        dob_estimate: dob_estimate,
        gender: 'female',
        birthplace: nil,
        residence_requirement_met: nil,
        residence_history: nil,
        phone_number_provided: nil,
        phone_number: nil,
        email: nil,
        voicemail_consent: nil,
        phone_number_unknown: nil,
        email_unknown: nil,
        privacy_known: nil,
        are_contact_details_private: are_contact_details_private,
        cohabit_with_other: cohabit_with_other,
        type: 'OtherParty'
      )
    }

    let(:contact_details_private) { [] }

    before do
      allow(PrivacyChange).to receive(:changes_apply?).and_return(true)
      allow(other_party).to receive(:full_address).and_return('full address')
      allow(other_party).to receive(:email_private?).and_return(contact_details_private.include?('email'))
      allow(other_party).to receive(:phone_number_private?).and_return(contact_details_private.include?('phone_number'))
      allow(other_party).to receive(:address_private?).and_return(contact_details_private.include?('address'))
      allow(other_party).to receive(:refuge)
    end

    subject { described_class.new(c100_application) }

    let(:has_previous_name) { 'no' }
    let(:previous_name) { nil }
    let(:dob) { Date.new(2018, 1, 20) }
    let(:dob_estimate) { nil }
    let(:cohabit_with_other) { 'yes' }
    let(:are_contact_details_private) { 'no' }

    let(:answers) { subject.answers }

    describe '#name' do
      it { expect(subject.name).to eq(:other_parties_details) }
    end

    describe '#show_header?' do
      it { expect(subject.show_header?).to eq(false) }
    end

    describe '#record_collection' do
      it {
        expect(c100_application).to receive(:other_parties)
        subject.record_collection
      }

      it {
        expect(subject.record_collection).not_to be_an_instance_of(C8CollectionProxy)
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
          other_party, show_person_name: false
        ).and_return('relationships')
      end

      it 'has the correct number of rows' do
        expect(answers.count).to eq(10)
      end

      it 'has the correct rows in the right order' do
        expect(answers[0]).to be_an_instance_of(Separator)
        expect(answers[0].title).to eq('other_parties_details_index_title')
        expect(answers[0].i18n_opts).to eq({index: 1})

        expect(answers[1]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[1].question).to eq(:person_full_name)
        expect(answers[1].value).to eq('fullname')

        expect(answers[2]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[2].question).to eq(:person_cohabit_other)
        expect(answers[2].value).to eq('Yes')

        expect(answers[3]).to be_an_instance_of(FreeTextAnswer)
        expect(answers[3].question).to eq(:person_contact_details_private)
        expect(answers[3].value).to eq('No')

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

      context 'when no other parties present' do
        let(:other_parties) { [] }

        it 'has the correct number of rows' do
          expect(answers.count).to eq(1)
        end

        it 'has the correct rows in the right order' do
          expect(answers[0]).to be_an_instance_of(Separator)
          expect(answers[0].title).to eq(:not_applicable)
        end
      end

      context 'when confidentiality is enabled' do
        let(:are_contact_details_private) { GenericYesNo::YES.to_s }

        it 'has the correct number of rows' do
          expect(answers.count).to eq(2)
        end

        it 'has the correct rows in the right order' do
          expect(answers[0]).to be_an_instance_of(Separator)
          expect(answers[0].title).to eq("other_parties_details_index_title")

          expect(answers[1]).to be_an_instance_of(Separator)
          expect(answers[1].title).to eq(:c8_attached)
        end
      end
    end
  end
end
