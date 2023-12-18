require 'rails_helper'

RSpec.describe C100Application, type: :model do
  subject { described_class.new(attributes) }
  let(:attributes) { {} }

  REDIRECT_POSTCODES = %w[EN1 EN2 EN3 EN4 HA0 HA1 HA3 HA8 N10 N11 N12 N13 N14 N17 N18 N2 N20 N21 N22 N3 N9 NW11 NW4 NW7 NW9].freeze

  describe 'status enum' do
    it 'has the right values' do
      expect(
        described_class.statuses
      ).to eq(
        'screening' => 0,
        'in_progress' => 1,
        'payment_in_progress' => 8,
        'completed' => 10,
      )
    end
  end

  describe 'reminder_status enum' do
    it 'has the right values' do
      expect(
        described_class.reminder_statuses
      ).to eq(
        'first_reminder_sent' => 'first_reminder_sent',
        'last_reminder_sent' => 'last_reminder_sent',
      )
    end
  end


  describe 'court redirections' do

    let(:attributes) {{
      court: court,
      urgent_hearing: urgent_hearing,
      without_notice: without_notice,
      children_postcode: children_postcode
    }}

    # :nocov:
    context 'with west-london court' do
      let(:court) {
        Court.find_or_create_by(
          id: 'west-london-family-court') do | court|
          court.name = "Barnet Civil and Family Courts Centre",
          court.gbs = "unknown",
          court.cci_code = 117,
          court.address = {},
          court.email = "test@example.com"
        end
      }
      context 'with urgency and without notice' do
        let(:urgent_hearing){'yes'}
        let(:without_notice){'yes'}
        let(:children_postcode){ 'N2 0AA'}

        context 'when given lowercase children_postcode' do
          let(:children_postcode){'n2 0aa'}

          it 'redirects urgent hearings from
            west london family court to barnet civil
            and family courts' do
            subject.save
            expect(subject.court.id).to eq('barnet-civil-and-family-courts-centre')
          end
        end

        context 'when given uppercase children_postcode' do
          let(:children_postcode){'N2 0AA'}

          it 'redirects urgent hearings from
            west london family court to barnet civil
            and family courts' do
            subject.save
            expect(subject.court.id).to eq('barnet-civil-and-family-courts-centre')
          end
        end

        context 'when given a postcode with no spaces' do
          let(:children_postcode){'n20AA'}

          it 'redirects urgent hearings from
            west london family court to barnet civil
            and family courts' do
            subject.save
            expect(subject.court.id).to eq('barnet-civil-and-family-courts-centre')
          end
        end
      end

      context 'without urgency' do
        let(:urgent_hearing){'no'}
        let(:without_notice){'yes'}
        let(:children_postcode){'N2 0AA'}

        it 'does not redirect non-urgent' do
          subject.save
          expect(subject.court.id).to eq('west-london-family-court')
        end
      end

      context 'without notice' do
        let(:urgent_hearing){'yes'}
        let(:without_notice){'no'}
        let(:children_postcode){'NW8 0RH'}

        it 'does not redirect non-notice' do
          subject.save
          expect(subject.court.id).to eq('west-london-family-court')
        end
      end

      context 'with urgency, then without urgency' do
        let(:urgent_hearing){'yes'}
        let(:without_notice){'yes'}

        context 'when given lowercase children_postcode' do
          let(:children_postcode){'n2 0aa'}

          it 'redirects, then does not redirect non-urgent' do
            subject.save
            expect(subject.court.id).to eq('barnet-civil-and-family-courts-centre')

            subject.update(urgent_hearing: 'no')
            expect(subject.court.id).to eq('west-london-family-court')
          end
        end

        context 'when given uppercase children_postcode' do
          let(:children_postcode){'N2 0AA'}

          it 'redirects, then does not redirect non-urgent' do
            subject.save
            expect(subject.court.id).to eq('barnet-civil-and-family-courts-centre')

            subject.update(urgent_hearing: 'no')
            expect(subject.court.id).to eq('west-london-family-court')
          end
        end
      end
    end

    context 'with non-west-london court' do
      let(:court) {
        Court.find_or_create_by(id: 'other-court') do | court|
          court.name = "Other",
          court.gbs = "unknown",
          court.cci_code = 117,
          court.address = {},
          court.email = "test@example.com"
        end
      }
      let(:urgent_hearing){'yes'}
      let(:without_notice){'yes'}
      let(:children_postcode){'NW8 0RH'}
      it 'does not redirect to other courts' do
        subject.save
        expect(subject.court.id).to eq('other-court')
      end
    end
    # :nocov:

  end


  describe '.purge!' do
    let(:finder_double) { double.as_null_object }

    before do
      travel_to Time.now
    end

    it 'picks records equal to or older than the passed-in date' do
      expect(described_class).to receive(:where).with(
        'c100_applications.created_at <= :date', date: 28.days.ago
      ).and_return(finder_double)

      described_class.purge!(28.days.ago)
    end

    it 'picks records that have not been updated for the past 20 minutes' do
      expect(described_class).to receive(:where).and_return(finder_double)

      expect(finder_double).to receive(:where).with(
        'c100_applications.updated_at <= :date', date: 20.minutes.ago
      ).and_return(finder_double)

      described_class.purge!(28.days.ago)
    end

    it 'calls #destroy_all on the records it finds' do
      allow(described_class).to receive(:where).and_return(finder_double)
      expect(finder_double).to receive(:destroy_all)

      described_class.purge!(28.days.ago)
    end
  end

  describe '#online_payment?' do
    context 'for `online` values' do
      let(:attributes) { {payment_type: 'online'} }
      it { expect(subject.online_payment?).to eq(true) }
    end

    context 'for other values' do
      let(:attributes) { {payment_type: 'whatever'} }
      it { expect(subject.online_payment?).to eq(false) }
    end
  end

  describe '#consent_order?' do
    context 'for a `nil` value' do
      let(:attributes) { {consent_order: nil} }
      it { expect(subject.consent_order?).to eq(false) }
    end

    context 'for a `no` value' do
      let(:attributes) { {consent_order: 'no'} }
      it { expect(subject.consent_order?).to eq(false) }
    end

    context 'for a `yes` value' do
      let(:attributes) { {consent_order: 'yes'} }
      it { expect(subject.consent_order?).to eq(true) }
    end
  end

  describe '#child_protection_cases?' do
    context 'for a `nil` value' do
      let(:attributes) { {child_protection_cases: nil} }
      it { expect(subject.child_protection_cases?).to eq(false) }
    end

    context 'for a `no` value' do
      let(:attributes) { {child_protection_cases: 'no'} }
      it { expect(subject.child_protection_cases?).to eq(false) }
    end

    context 'for a `yes` value' do
      let(:attributes) { {child_protection_cases: 'yes'} }
      it { expect(subject.child_protection_cases?).to eq(true) }
    end
  end

  describe '#confidentiality_enabled?' do
    context 'where an applicant is private, is true' do
      it {
        a = Applicant.create(c100_application: subject,
          are_contact_details_private: 'yes')
        expect(subject.confidentiality_enabled?).to eq(true)
        a.destroy 
      }
    end

    context 'where applicants are not private, is false' do
      it { 
        a = Applicant.create(c100_application: subject,
          are_contact_details_private: 'no')
        expect(subject.confidentiality_enabled?).to eq(false)
        a.destroy
      }
    end
  end

  describe '#has_solicitor?' do
    context 'for a `nil` value' do
      let(:attributes) { {has_solicitor: nil} }
      it { expect(subject.has_solicitor?).to eq(false) }
    end

    context 'for a `no` value' do
      let(:attributes) { {has_solicitor: 'no'} }
      it { expect(subject.has_solicitor?).to eq(false) }
    end

    context 'for a `yes` value' do
      let(:attributes) { {has_solicitor: 'yes'} }
      it { expect(subject.has_solicitor?).to eq(true) }
    end
  end

  describe '#has_safety_concerns?' do
    let(:attributes) { {
      domestic_abuse: domestic_abuse,
      risk_of_abduction: 'no',
      children_abuse: 'no',
      substance_abuse: 'no',
      other_abuse: 'no'
    } }

    context 'at least one concern was answered as `YES`' do
      let(:domestic_abuse) { 'yes' }
      it { expect(subject.has_safety_concerns?).to eq(true) }
    end

    context 'there are no concerns' do
      let(:domestic_abuse) { 'no' }
      it { expect(subject.has_safety_concerns?).to eq(false) }

      it 'checks all the neccessary attributes' do
        expect(subject).to receive(:domestic_abuse)
        expect(subject).to receive(:risk_of_abduction)
        expect(subject).to receive(:children_abuse)
        expect(subject).to receive(:substance_abuse)
        expect(subject).to receive(:other_abuse)

        subject.has_safety_concerns?
      end
    end
  end

  describe '#mark_as_urgent?' do
    context 'when urgent_hearing is yes and there is a safety concern' do
      let(:attributes) { { urgent_hearing: 'yes', risk_of_abduction: 'yes' } }
      it { expect(subject.mark_as_urgent?).to eq(true) }
    end

    context 'when urgent_hearing is not yes' do
      let(:attributes) { { urgent_hearing: 'no' } }
      it { expect(subject.mark_as_urgent?).to eq(false) }
    end
  end


  describe '#mark_as_completed!' do
    before do
      travel_to Time.at(123)
    end

    it 'marks the application as completed and saves the audit record' do
      expect(
        subject
      ).to receive(:update!).with(
        status: :completed, completed_at: Time.at(123)
      ).and_return(true)

      expect(CompletedApplicationsAudit).to receive(:log!).with(subject)

      subject.mark_as_completed!
    end

    context 'transaction' do
      let(:attributes) { {
        status: :in_progress
      } }

      # In these tests we are testing DB transactions, so we need to persist
      # the record, and cleanup after we are finished with it.
      before do
        subject.save
      end

      after do
        subject.destroy
      end

      it 'reverts the application status to how it was before (rollbacks)' do
        expect(subject.status).to eq('in_progress')
        expect(subject).to receive(:update!).and_call_original

        expect { subject.mark_as_completed! }.to raise_error

        expect(subject.reload.status).to eq('in_progress')
        expect(subject.reload.completed_at).to be_nil
      end
    end
  end

  describe '#documents' do
    let(:files_collection_ref) { 'b2411f49-db48-4074-b26a-944002bcebf1' }
    let(:attributes) { {
      files_collection_ref: files_collection_ref
    } }
    let(:file) { double('file') }
    it 'returns documents for this application' do
      expect(Document).to receive(:all_for_collection).with(
        files_collection_ref
      ).and_return({
        doc_key: [file]
      })
      expect(subject.documents(:doc_key)).to eq([file])
    end
  end

  describe '#document' do
    let(:files_collection_ref) { 'b2411f49-db48-4074-b26a-944002bcebf1' }
    let(:attributes) { {
      files_collection_ref: files_collection_ref
    } }
    let(:file) { double('file') }
    it 'returns documents for this application' do
      expect(Document).to receive(:all_for_collection).with(
        files_collection_ref
      ).and_return({
        doc_key: [file]
      })
      expect(subject.document(:doc_key)).to eq(file)
    end

    it 'returns nil when no application present' do
      expect(Document).to receive(:all_for_collection).with(
        files_collection_ref
      ).and_return({
        doc_key: []
      })
      expect(subject.document(:doc_key)).to eq(nil)
    end
  end
end

