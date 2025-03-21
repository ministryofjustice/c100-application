module Backoffice
  class DashboardController < Backoffice::ApplicationController
    include Auth0Secured

    def index
      @form = Backoffice::LookupForm.new

      @report = completed_report
      @payments_report = payments_report
    end

    def lookup
      @form = Backoffice::LookupForm.new(form_params)
      @report = []

      # rubocop:disable Lint/LiteralAsCondition
      render :lookup && return if @form.invalid?
      # rubocop:enable Lint/LiteralAsCondition

      if @form.reference_code.present?
        search_by_reference_code
      else
        search_by_email
      end
    end

    # Will change the payment method to phone, as a fallback, as this is most likely
    # an application having issues with online payments, or an user not fully completing
    # the payment journey and letting the payment expire (time out).
    # This is mainly an issue with non-saved applications as the user can't return to it.
    # Mark as completed and trigger the submission emails.
    #
    def complete_application
      c100_application = C100Application.not_completed.find(params[:dashboard_id])

      c100_application.update_column(
        :payment_type, PaymentType::SELF_PAYMENT_CARD.value
      )

      c100_application.mark_as_completed!
      C100App::OnlineSubmissionQueue.new(c100_application).process

      audit!(
        action: :application_completed,
        details: { reference_code: c100_application.reference_code, payment_type: c100_application.payment_type }
      )

      redirect_to backoffice_dashboard_index_path, flash: {
        alert: "Application #{c100_application.reference_code} has been completed and emails will be sent shortly."
      }, allow_other_host: true
    end

    private

    def form_params
      params.require(:backoffice_lookup_form).permit(:reference_code, :email_address)
    end

    def default_limit
      50
    end

    def completed_report
      CompletedApplicationsAudit.unscoped.order(completed_at: :desc).limit(default_limit)
    end

    def payments_report
      PaymentIntent.order(updated_at: :desc).limit(default_limit)
    end

    def search_by_email
      if (@application = C100Application.find_by_receipt_email(@form.email_address))
        audit!(
          action: :application_lookup,
          details: { email_address: @form.email_address, found: true, completed: @application.completed? }
        )
      else
        audit!(
          action: :application_lookup,
          details: { email_address: @form.email_address, found: false }
        )
      end
    end

    def search_by_reference_code
      if (@application = CompletedApplicationsAudit.find_by(reference_code: @form.reference_code))
        audit!(
          action: :application_lookup,
          details: { reference_code: @form.reference_code, found: true, completed: true }
        )
      elsif (@application = C100Application.find_by_reference_code(@form.reference_code))
        audit!(
          action: :application_lookup,
          details: { reference_code: @form.reference_code, found: true, completed: false }
        )
      else
        audit!(
          action: :application_lookup,
          details: { reference_code: @form.reference_code, found: false }
        )
      end
    end
  end
end
