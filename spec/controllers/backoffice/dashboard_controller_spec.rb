require 'rails_helper'

RSpec.describe Backoffice::DashboardController do
  before do
    session[:backoffice_userinfo] = { "info" => {"name" => "Test User" }}
  end

  let(:audit_search_result) { nil }
  let(:application_search_result) { nil }
  let(:c100_application) { C100Application.new }

  describe '#lookup reference' do
    before do
      allow(CompletedApplicationsAudit).to receive(:find_by).and_return audit_search_result
      allow(C100Application).to receive(:find_by_reference_code).and_return application_search_result
      allow(BackofficeAuditRecord).to receive(:log!)
    end

    context 'Application audit lookup' do
      let(:audit_search_result) { c100_application }

      before do
        get :lookup, params: { backoffice_lookup_form: { reference_code: '2021/05/CD7A69BC' }}
      end
      it { expect(CompletedApplicationsAudit).to have_received(:find_by).with(reference_code: '2021/05/CD7A69BC') }
      it { expect(C100Application).not_to have_received(:find_by_reference_code) }
      it {
        details = { completed: true, found: true, reference_code: "2021/05/CD7A69BC" }
        expect(BackofficeAuditRecord).to have_received(:log!).with(hash_including(details: details))
      }
    end

    context 'Application lookup' do
      let(:audit_search_result) { nil }
      let(:application_search_result) { c100_application }

      before do
        get :lookup, params: { backoffice_lookup_form: { reference_code: '2021/05/CD7A69BC' }}
      end
      it { expect(CompletedApplicationsAudit).to have_received(:find_by).with(reference_code: '2021/05/CD7A69BC') }
      it { expect(C100Application).to have_received(:find_by_reference_code) }
      it {
        details = { completed: false, found: true, reference_code: "2021/05/CD7A69BC" }
        expect(BackofficeAuditRecord).to have_received(:log!).with(hash_including(details: details))
      }
    end

    context 'Application not found' do
      let(:audit_search_result) { nil }
      let(:application_search_result) { nil }

      before do
        get :lookup, params: { backoffice_lookup_form: { reference_code: '2021/05/CD7A69BC' }}
      end
      it { expect(CompletedApplicationsAudit).to have_received(:find_by).with(reference_code: '2021/05/CD7A69BC') }
      it { expect(C100Application).to have_received(:find_by_reference_code) }
      it {
        details = { found: false, reference_code: "2021/05/CD7A69BC"}
        expect(BackofficeAuditRecord).to have_received(:log!).with(hash_including(details: details))
      }
    end
  end

  describe '#lookup email' do
    before do
      allow(CompletedApplicationsAudit).to receive(:find_by)
      allow(C100Application).to receive(:find_by_reference_code)
      allow(C100Application).to receive(:find_by_receipt_email).and_return application_search_result
      allow(BackofficeAuditRecord).to receive(:log!)
    end

    context 'Application email lookup found' do
      let(:application_search_result) { c100_application }

      before do
        get :lookup, params: { backoffice_lookup_form: { email_address: 'test@hmcts.net' }}
      end

      it { expect(CompletedApplicationsAudit).not_to have_received(:find_by) }
      it { expect(C100Application).not_to have_received(:find_by_reference_code) }
      it { expect(C100Application).to have_received(:find_by_receipt_email) }
      it {
        details = { completed: false, found: true, email_address: "test@hmcts.net" }
        expect(BackofficeAuditRecord).to have_received(:log!).with(hash_including(details: details))
      }
    end

    context 'Application email lookup found completed' do
      let(:application_search_result) { c100_application }

      before do
        allow(c100_application).to receive(:completed?).and_return true
        get :lookup, params: { backoffice_lookup_form: { email_address: 'test@hmcts.net' }}
      end

      it { expect(C100Application).to have_received(:find_by_receipt_email) }
      it {
        details = { completed: true, found: true, email_address: "test@hmcts.net" }
        expect(BackofficeAuditRecord).to have_received(:log!).with(hash_including(details: details))
      }
    end

    context 'Application email lookup not found' do
      let(:application_search_result) { nil }

      before do
        get :lookup, params: { backoffice_lookup_form: { email_address: 'test@hmcts.net' }}
      end

      it { expect(C100Application).to have_received(:find_by_receipt_email) }
      it {
        details = { found: false, email_address: "test@hmcts.net" }
        expect(BackofficeAuditRecord).to have_received(:log!).with(hash_including(details: details))
      }
    end
  end
end
