module Backoffice
  class EmailsController < Backoffice::ApplicationController
    include Auth0Secured

    def index
      @form = Backoffice::LookupForm.new
      @report = Reports::FailedEmailsReport.list
    end

    def lookup
      @form = Backoffice::LookupForm.new(form_params)
      @report = []

      # rubocop:disable Lint/LiteralAsCondition
      render :lookup && return if @form.invalid?
      # rubocop:enable Lint/LiteralAsCondition

      @report = EmailSubmissionsAudit.find_records(@form.reference_code, @form.email_address)
      @submission = email_submission_details(@form.reference_code, @form.email_address)

      audit!(
        action: :email_lookup,
        details: { reference_code: @form.reference_code, email_address: @form.email_address, found: @report.size }
      )
    end

    def resend
      email = EmailSubmission.find(params[:email_id])
      type  = params[:type]

      email.resend!(type:)
      audit_resend(email, resend_type: type)

      redirect_to backoffice_emails_path, flash: {
        alert: 'Email resend in progress.'
      }, allow_other_host: true
    end

    private

    def form_params
      params.require(:backoffice_lookup_form).permit(
        :reference_code,
        :email_address,
      )
    end

    def email_submission_details(reference, email = nil)
      email_submission = C100Application.find_by_reference_code(reference).try(:email_submission)
      return if email_submission.nil?

      email_submission if [
        email_submission.to_address,
        email_submission.email_copy_to,
        nil
      ].include?(email.presence)
    end

    def audit_resend(email, resend_type:)
      details = {
        reference_code: email.c100_application.reference_code
      }

      if resend_type == 'court'
        details[:recipient] = email.to_address
      elsif resend_type == 'user'
        details[:recipient] = email.email_copy_to
      end

      audit!(action: :resend_email, details:)
    end
  end
end
