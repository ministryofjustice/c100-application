require 'rails_helper'

RSpec.describe C100App::CourtOnlineSubmission do
  let(:c100_application) { instance_double(C100Application, email_submission: email_submission, screener_answers_court: screener_answers_court) }
  let(:email_submission) { instance_double(EmailSubmission, update: true) }
  let(:screener_answers_court) { double(email: 'court@email.com') }

  subject { described_class.new(c100_application) }

  describe '#to_address' do
    it { expect(subject.to_address).to eq('court@email.com') }
  end

  describe '#process' do
    let(:pdf_presenter) { instance_double(Summary::PdfPresenter, generate: true, to_pdf: 'pdf content') }
    let(:c8_split_enabled) { false }

    before do
      allow(Summary::PdfPresenter).to receive(:new).with(c100_application).and_return(pdf_presenter)
      allow(subject).to receive(:enable_c8_split?).and_return(c8_split_enabled) # temporary feature-flag
    end

    context '#generate_documents' do
      before do
        allow(subject).to receive(:deliver_email) # do not care here about the email
      end

      context 'C8 split feature-flag enabled' do
        let(:c8_split_enabled) { true }

        it 'generates a bundle with C100 and C1A and a separate C8 form' do
          expect(pdf_presenter).to receive(:generate).with(:c100, :c1a).ordered
          expect(pdf_presenter).to receive(:generate).with(:c8).ordered
          subject.process

          expect(subject.documents.size).to eq(2)
          expect(subject.documents.keys).to match_array([:bundle, :c8_form])
        end
      end

      context 'C8 split feature-flag disabled' do
        it 'generates all 3 forms in a PDF bundle' do
          expect(pdf_presenter).to receive(:generate).with(no_args)
          subject.process

          expect(subject.documents.size).to eq(1)
          expect(subject.documents.keys).to match_array([:bundle])
        end
      end
    end

    context '#deliver_email' do
      let(:mailer) { spy('mailer') }

      before do
        allow(NotifySubmissionMailer).to receive(:with).with(
          c100_application: c100_application, documents: { bundle: kind_of(StringIO) }
        ).and_return(mailer)
      end

      it 'delivers the email to the applicant' do
        expect(
          mailer
        ).to receive(:application_to_court).with(to_address: 'court@email.com')

        expect(mailer).to receive(:deliver_now)

        subject.process
      end
    end

    context '#audit_data' do
      before do
        allow(subject).to receive(:generate_pdf).and_return(true)
        allow(subject).to receive(:deliver_email).and_return(true)

        travel_to Time.at(0)
      end

      it 'audits the submission details' do
        expect(email_submission).to receive(:update).with(
          to_address: 'court@email.com', sent_at: Time.at(0)
        )

        subject.process
      end
    end
  end
end
