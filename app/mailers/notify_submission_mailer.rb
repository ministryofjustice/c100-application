class NotifySubmissionMailer < NotifyMailer
  include FeesHelper

  # Notify doesn't care about the `from` address, but we use it in the interceptor.
  #
  # It can be `nil`, as the interceptor will then make Notify fail email validation,
  # which is a valid outcome when testing on local or staging environments.
  #
  default from: -> { @c100_application.receipt_email }

  before_action do
    @c100_application = params[:c100_application]
    @documents = params[:documents]
  end

  #
  # Note: when some values are `nil`, we set a default. The only purpose of this
  # is to be able to use the `bypass` functionality on test environments, without
  # having to fill the whole application.
  #

  def application_to_court(to_address:)
    set_template(:application_submitted_to_court)
    set_reference("court;#{@c100_application.reference_code}")

    build_draft_document_variables

    set_personalisation(
      shared_personalisation.merge(
        urgent: @c100_application.urgent_hearing || 'no',
        c8_included: @c100_application.confidentiality_enabled? ? 'yes' : 'no',
        link_to_c8_pdf: prepare_upload(@documents[:c8_form]),
        link_to_pdf: prepare_upload(@documents[:bundle]),
        link_to_json: prepare_upload(@documents[:json_form]),
        has_consent_order_draft: @has_consent_order_draft,
        link_to_consent_order_draft_document:
          @link_to_consent_order_draft_document
      )
    )

    mail(to: to_address)
  end

  def build_draft_document_variables
    if (draft = @c100_application.document(:consent_order_draft))
      download_token = draft.generate_download_token(@c100_application)
      @link_to_consent_order_draft_document =
        download_token_url(download_token.token)
      @has_consent_order_draft = true
    else
      @link_to_consent_order_draft_document = ''
      @has_consent_order_draft = false
    end
  end

  def application_to_user(to_address:)
    set_template(:application_submitted_to_user)
    set_reference("user;#{@c100_application.reference_code}")

    set_personalisation(
      shared_personalisation.merge(
        court_name: court.name,
        court_email: court.email,
        court_url: court.url,
        court_address: court.full_address.join("\n"),
        documents_email: court.documents_email,
        is_under_age: notify_boolean(@c100_application.applicants.under_age?),
        is_consent_order: @c100_application.consent_order || 'no',
        payment_instructions: payment_instructions,
      )
    )

    mail(to: to_address)
  end

  private

  def shared_personalisation
    {
      applicant_name: @c100_application.declaration_signee,
      reference_code: @c100_application.reference_code,
    }
  end

  def payment_instructions
    I18n.translate!(
      @c100_application.payment_type,
      scope: [:notify_submission_mailer, :payment_instructions],
      fee: fee_amount,
    )
  end

  def prepare_upload(file)
    return '' if file.nil? || file.size.zero?
    Notifications.prepare_upload(file)
  end

  def court
    @c100_application.court
  end
end
