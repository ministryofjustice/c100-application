require 'spec_helper'

RSpec.describe NotifySubmissionMailer, type: :mailer do
  let(:c100_application) {
    C100Application.new(
      id: '4a362e1c-48eb-40e3-9458-a36ead3f30a4',
      created_at: Time.at(0),
      receipt_email: 'receipt@example.com',
      consent_order: 'yes',
      urgent_hearing: 'yes',
      risk_of_abduction: 'yes',
      payment_type: 'foobar_payment',
      declaration_signee: 'John Doe',
    )
  }

  let(:court) {
    Court.new(
      name: 'Test court',
      email: 'court@example.com',
      slug: 'test-court',
      address: {
        "town" => 'town',
        "postcode" => 'postcode',
        "address_lines" => %w(street1 street2),
      }
    )
  }

  before do
    allow(
      Rails.configuration
    ).to receive(:govuk_notify_templates).and_return(
      application_submitted_to_court: 'application_submitted_to_court_template_id',
      application_submitted_to_user: 'application_submitted_to_user_template_id',
    )
    allow(Document).
      to receive(:all_for_collection).
      and_return({ draft_consent_order: [] })

    allow(I18n).to receive(:translate!).with('service.name').and_return(
      'Apply to court about child arrangements'
    )
  end

  describe '#application_to_court' do
    let(:documents) { { bundle: StringIO.new('bundle pdf'), c8_form: c8_form, json_form: tmp_file } }
    let(:c8_form) { StringIO.new('') }
    let(:tmp_file) {
      tmp = Tempfile.new('test')
      tmp << 'test2'
      tmp.rewind
      tmp
    }

    let(:mail) {
      described_class.with(
        c100_application: c100_application, documents: documents
      ).application_to_court(to_address: 'court@example.com')
    }

    it_behaves_like 'a Notify mail', template_id: 'application_submitted_to_court_template_id'

    it { expect(mail.to).to eq(['court@example.com']) }
    it { expect(mail.from).to eq(['receipt@example.com']) }

    it 'has the right reference' do
      expect(mail.govuk_notify_reference).to eq('court;1970/01/4A362E1C')
    end

    context 'with attachments' do

      let(:c100_application) { C100Application.create({
        urgent_hearing: "yes",
        risk_of_abduction: "yes",
        declaration_signee: "John Doe"
      })}
      let(:draft_consent_order_file_key) { '39d2bFDf912das3gD' }
      let(:draft_consent_order) { Document.new({ 
        name: draft_consent_order_file_key,
        collection_ref: '123'
      }) }
      let(:miam_certificate_file_key) { '39d2bFDf912eas3gD' }
      let(:miam_certificate) { Document.new({ 
        name: miam_certificate_file_key,
        collection_ref: '123'
      }) }
      let(:exemption_file_key) { '39d2bFDf912fas3gD' }
      let(:exemption) { Document.new({
        name: exemption_file_key,
        collection_ref: '123'
      }) }
      let(:existing_court_order_file_key) { '39d2bFDf912gas3gD' }
      let(:existing_court_order) { Document.new({
        name: existing_court_order_file_key,
        collection_ref: '123'
      }) }

      before do
        allow_any_instance_of(C100Application).to receive(
          :reference_code
        ).and_return('2022/11/0F8464CD')
        allow(Document).
          to receive(:all_for_collection).
          and_return({ miam_certificate: [miam_certificate],
                       draft_consent_order: [draft_consent_order],
                       exemption: [exemption],
                       existing_court_order: [existing_court_order]
                     })
      end

      it 'has the right personalisation' do
        allow(c100_application).to receive(:confidentiality_enabled?).
          and_return(false)

        expect(mail.govuk_notify_personalisation).to eq({
          service_name: 'Apply to court about child arrangements',
          applicant_name: 'John Doe',
          reference_code: '2022/11/0F8464CD',
          safety_concerns: 'yes',
          urgent: 'yes',
          c8_included: 'no',
          link_to_c8_pdf: '',
          link_to_pdf: { 
            file: 'YnVuZGxlIHBkZg==',
            filename: nil,
            confirm_email_before_download: false,
            retention_period: nil },
          link_to_json: {
            file: 'dGVzdDI=',
            filename: nil,
            confirm_email_before_download: false,
            retention_period: nil },
          has_attachments: true,
          has_draft_consent_order: true,
          link_to_draft_consent_order:
            download_token_url(c100_application.download_tokens.find_by(
              key: draft_consent_order_file_key).token),
          has_miam_certificate: true,
          link_to_miam_certificate:
            download_token_url(c100_application.download_tokens.find_by(
              key: miam_certificate_file_key).token),
          has_exemption: true,
          link_to_exemption:
            download_token_url(c100_application.download_tokens.find_by(
              key: exemption_file_key).token),
          has_existing_court_order: true,
          link_to_existing_court_order:
            download_token_url(c100_application.download_tokens.find_by(
              key: existing_court_order_file_key).token),
        })
      end
    end

    context 'without attachments' do

      before do
        allow_any_instance_of(C100Application).to receive(
          :reference_code
        ).and_return('2022/11/0F8464CD')
        allow(Document).
          to receive(:all_for_collection).
          and_return({ draft_consent_order: [] })
      end

      it 'has the right personalisation' do
        allow(c100_application).to receive(:confidentiality_enabled?).
          and_return(false)

        expect(mail.govuk_notify_personalisation).to eq({
          service_name: 'Apply to court about child arrangements',
          applicant_name: 'John Doe',
          reference_code: '2022/11/0F8464CD',
          safety_concerns: 'yes',
          urgent: 'yes',
          c8_included: 'no',
          link_to_c8_pdf: '',
          link_to_pdf: { file: 'YnVuZGxlIHBkZg==', filename: nil,
            confirm_email_before_download: false,
            retention_period: nil },
          link_to_json: { file: 'dGVzdDI=', filename: nil,
            confirm_email_before_download: false,
            retention_period: nil },
          has_attachments: false,
          has_draft_consent_order: false,
          link_to_draft_consent_order: '',
          has_miam_certificate: false,
          link_to_miam_certificate: '',
          has_exemption: false,
          link_to_exemption: '',
          has_existing_court_order: false,
          link_to_existing_court_order: '',
        })
      end
    end

    context 'and applicant has private contact details' do
      let(:c8_form) { StringIO.new('c8 form') }

      it 'has the right personalisation' do
        allow(c100_application).to receive(:confidentiality_enabled?).
          and_return(true)

        expect(
          mail.govuk_notify_personalisation
        ).to match(hash_including(
          c8_included: 'yes',
          link_to_c8_pdf: { file: 'YzggZm9ybQ==', filename: nil,
          confirm_email_before_download: false,
          retention_period: nil },
          link_to_pdf: { file: 'YnVuZGxlIHBkZg==', filename: nil,
          confirm_email_before_download: false,
          retention_period: nil },
        ))
      end
    end
  end

  describe '#application_to_user' do
    before do
      allow(c100_application).to receive(:court).and_return(court)

      allow(I18n).to receive(:translate!).with(
        'foobar_payment', scope: [:notify_submission_mailer, :payment_instructions], fee: '£263'
      ).and_return('payment instructions from locales')
    end

    # We don't send the PDF to the applicant anymore, so this hash is empty
    let(:documents) { {} }

    let(:mail) {
      described_class.with(
        c100_application: c100_application, documents: documents
      ).application_to_user(to_address: 'user@example.com')
    }

    it_behaves_like 'a Notify mail', template_id: 'application_submitted_to_user_template_id'

    it { expect(mail.to).to eq(['user@example.com']) }
    it { expect(mail.from).to eq(['receipt@example.com']) }

    it 'has the right reference' do
      expect(mail.govuk_notify_reference).to eq('user;1970/01/4A362E1C')
    end

    it 'has the right personalisation' do
      expect(mail.govuk_notify_personalisation).to eq({
        service_name: 'Apply to court about child arrangements',
        applicant_name: 'John Doe',
        reference_code: '1970/01/4A362E1C',
        court_name: 'Test court',
        court_email: 'court@example.com',
        court_url: 'https://www.find-court-tribunal.service.gov.uk/courts/test-court',
        is_under_age: 'no',
        is_consent_order: 'yes',
        payment_instructions: 'payment instructions from locales',
      })
    end

    context 'when at least one applicant is under age' do
      let(:applicants_collection_double) { double(under_age?: true) }

      before do
        allow(c100_application).to receive(:applicants).and_return(applicants_collection_double)
      end

      it 'has the right personalisation' do
        expect(
          mail.govuk_notify_personalisation
        ).to include(is_under_age: 'yes')
      end
    end

    context 'when the court is centralised' do
      before do
        allow(court).to receive(:centralised?).and_return(true)
      end
    end
  end
end
