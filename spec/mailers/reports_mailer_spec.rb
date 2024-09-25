require 'spec_helper'

RSpec.describe ReportsMailer, type: :mailer do
  before do
    allow(
      Rails.configuration
    ).to receive(:govuk_notify_templates).and_return(
      failed_emails_report: 'failed_emails_report_template_id',
      payment_types_report: 'payment_types_report_template_id',
      submitted_applications_report: 'submitted_applications_report_template_id',
    )
  end

  describe '#failed_emails_report' do
    let(:mail) { described_class.failed_emails_report('report content', to_address: 'reports@example.com') }

    it_behaves_like 'a Notify mail', template_id: 'failed_emails_report_template_id'

    it { expect(mail.to).to eq(['reports@example.com']) }

    it 'has the right personalisation' do
      expect(mail.govuk_notify_personalisation).to eq({
        service_name: 'Apply to court about child arrangements',
        report_content: 'report content',
      })
    end
  end

  describe '#payment_types_report' do
    let(:mail) do
      described_class.payment_types_report(
        'Date,2021-12-20\npcd,10',
        to_address: 'reports@example.com',
        cc_address: 'copy@example.com'
      )
    end

    it_behaves_like 'a Notify mail', template_id: 'payment_types_report_template_id'

    it { expect(mail.to).to eq(['reports@example.com']) }
    it { expect(mail.cc).to eq(['copy@example.com']) }

    it 'has the right personalisation' do
      expect(mail.govuk_notify_personalisation).to eq({
        service_name: 'Apply to court about child arrangements',
        link_to_report: { 
          file: "RGF0ZSwyMDIxLTEyLTIwXG5wY2QsMTA=",
          filename: nil,
          confirm_email_before_download: nil,
          retention_period: nil
        },
      })
    end
  end

  describe '#submitted_applications_report' do
    let(:mail) do
      described_class.submitted_applications_report(
        'Date,2024-09-24\Reference Number,123\Date/Time Submitted,2024-09-20',
        to_address: 'reports@example.com',
      )
    end

    it_behaves_like 'a Notify mail', template_id: 'submitted_applications_report_template_id'

    it { expect(mail.to).to eq(['reports@example.com']) }

    it 'has the right personalisation' do
      expect(mail.govuk_notify_personalisation).to eq({
        service_name: 'Apply to court about child arrangements',
        link_to_report: {
          file: "RGF0ZSwyMDI0LTA5LTI0XFJlZmVyZW5jZSBOdW1iZXIsMTIzXERhdGUvVGltZSBTdWJtaXR0ZWQsMjAyNC0wOS0yMA==",
          filename: nil,
          confirm_email_before_download: nil,
          retention_period: nil
        },
      })
    end
  end
end
