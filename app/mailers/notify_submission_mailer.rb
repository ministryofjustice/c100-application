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

    document_personalisation = build_document_variables

    set_personalisation(
      shared_personalisation.merge(
        urgent: notify_boolean(@c100_application.mark_as_urgent?),
        safety_concerns: notify_boolean(@c100_application.has_safety_concerns?),
        c8_included: notify_boolean(@c100_application.confidentiality_enabled?),
        link_to_c8_pdf: prepare_upload(@documents[:c8_form]),
        link_to_pdf: prepare_upload(@documents[:bundle]),
        link_to_json: prepare_upload(@documents[:json_form]),
        **document_personalisation
      )
    )

    mail(to: to_address)
  end

  def application_to_user(to_address:)
    set_template(:application_submitted_to_user)
    set_reference("user;#{@c100_application.reference_code}")

    set_personalisation(
      shared_personalisation.merge(
        court_name: court.name,
        court_email: court.email,
        court_url: court.url,
        is_under_age: notify_boolean(@c100_application.applicants.under_age?),
        is_consent_order: @c100_application.consent_order || 'no',
        payment_instructions:,
      )
    )
    mail(to: to_address)
  end

  private

  def build_document_variables
    keys = %i[draft_consent_order miam_certificate exemption]
    keys.each { |key| build_variables_for_document(key) }

    personalisation = {}
    keys.each do |key|
      personalisation["has_#{key}".to_sym] =
        instance_variable_get("@has_#{key}")
      personalisation["link_to_#{key}".to_sym] =
        instance_variable_get("@link_to_#{key}")
    end
    personalisation[:has_attachments] = keys.any? { |key| instance_variable_get("@has_#{key}") }
    personalisation
  end

  def build_variables_for_document(key)
    if (draft = @c100_application.document(key))
      download_token = draft.generate_download_token(@c100_application)
      instance_variable_set "@link_to_#{key}",
                            download_token_url(download_token.token)
      instance_variable_set "@has_#{key}", true
    else
      instance_variable_set "@link_to_#{key}", ''
      instance_variable_set "@has_#{key}", false
    end
  end

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
    return '' if file.nil? ||
                 file.try(:string).try(:blank?) ||
                 file.try(:rewind).try(:blank?)
    Notifications.prepare_upload(file, confirm_email_before_download: false)
  end

  def court
    @c100_application.court
  end
end
