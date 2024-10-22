# rubocop:disable Metrics/ClassLength
class SessionsController < ApplicationController
  skip_before_action :ensure_session_validity, only: [:destroy]

  def ping
    head(:no_content)
  end

  def destroy
    reset_session

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render json: {} }
    end
  end

  # :nocov:
  def bypass_postcode
    raise 'For development use only' unless helpers.dev_tools_enabled?

    c100_application.update(
      court: find_or_initialize_court,
      status: 1,
    )

    redirect_to edit_steps_opening_consent_order_path
  end

  # rubocop:disable Metrics/AbcSize
  def bypass_to_cya
    raise 'For development use only' unless helpers.dev_tools_enabled?

    find_or_create_people

    c100_application.update(
      court: find_or_initialize_court,
      status: 1,
      consent_order: presence_or_default(c100_application.consent_order, 'no'),
      child_protection_cases: presence_or_default(c100_application.child_protection_cases, 'no'),
      attach_evidence: presence_or_default(c100_application.attach_evidence, 'yes'),
      payment_type: presence_or_default(c100_application.payment_type, 'help_with_fees'),
      declaration_signee: presence_or_default(c100_application.declaration_signee, 'name'),
      declaration_signee_capacity: presence_or_default(c100_application.declaration_signee_capacity, 'applicant'),
      declaration_confirmation: presence_or_default(c100_application.declaration_confirmation, 'applicant'),
      children_postcode: presence_or_default(c100_application.children_postcode, 'SW1H 9AJ'),
      orders: presence_or_default(c100_application.orders, ['child_arrangements_home'])
    )

    upload_bypass_document(:miam_certificate)

    redirect_to edit_steps_application_check_your_answers_path
  end

  # rubocop:disable Metrics/AbcSize
  def bypass_to_cya_consent
    raise 'For development use only' unless helpers.dev_tools_enabled?

    find_or_create_people

    c100_application.update(
      court: find_or_initialize_court,
      status: 1,
      consent_order: presence_or_default(c100_application.consent_order, 'yes'),
      declaration_signee: presence_or_default(c100_application.declaration_signee, 'name'),
      declaration_signee_capacity: presence_or_default(c100_application.declaration_signee_capacity, 'applicant'),
      declaration_confirmation: presence_or_default(c100_application.declaration_confirmation, 'applicant'),
      payment_type: presence_or_default(c100_application.payment_type, 'help_with_fees'),
      children_postcode: presence_or_default(c100_application.children_postcode, 'SW1H 9AJ'),
      orders: presence_or_default(c100_application.orders, ['child_arrangements_home'])
    )

    upload_bypass_document(:draft_consent_order)

    redirect_to edit_steps_application_check_your_answers_path
  end

  def bypass_to_cya_miam_certificate
    raise 'For development use only' unless helpers.dev_tools_enabled?

    find_or_create_people

    c100_application.update(
      court: find_or_initialize_court,
      status: 1,
      consent_order: presence_or_default(c100_application.consent_order, 'no'),
      declaration_signee: presence_or_default(c100_application.declaration_signee, 'name'),
      declaration_signee_capacity: presence_or_default(c100_application.declaration_signee_capacity, 'applicant'),
      declaration_confirmation: presence_or_default(c100_application.declaration_confirmation, 'applicant'),
      payment_type: presence_or_default(c100_application.payment_type, 'help_with_fees'),
      children_postcode: presence_or_default(c100_application.children_postcode, 'SW1H 9AJ'),
      miam_attended: presence_or_default(c100_application.miam_attended, 'yes'),
      miam_certification: presence_or_default(c100_application.miam_certification, 'yes'),
      orders: presence_or_default(c100_application.orders, ['child_arrangements_home']),
    )

    upload_bypass_document(:miam_certificate)

    redirect_to edit_steps_application_check_your_answers_path
  end

  def bypass_to_cya_miam_exemption
    raise 'For development use only' unless helpers.dev_tools_enabled?

    find_or_create_people

    c100_application.update(
      court: find_or_initialize_court,
      status: 1,
      consent_order: presence_or_default(c100_application.consent_order, 'no'),
      declaration_signee: presence_or_default(c100_application.declaration_signee, 'name'),
      declaration_signee_capacity: presence_or_default(c100_application.declaration_signee_capacity, 'applicant'),
      declaration_confirmation: presence_or_default(c100_application.declaration_confirmation, 'applicant'),
      payment_type: presence_or_default(c100_application.payment_type, 'help_with_fees'),
      miam_exemption_claim: presence_or_default(c100_application.miam_exemption_claim, 'yes'),
      attach_evidence: presence_or_default(c100_application.attach_evidence, 'yes'),
      children_postcode: presence_or_default(c100_application.children_postcode, 'SW1H 9AJ'),
      orders: presence_or_default(c100_application.orders, ['child_arrangements_home'])
    )

    redirect_to edit_steps_application_check_your_answers_path
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/ClassLength
  # :nocov:

  private

  # :nocov:
  def c100_application
    current_c100_application || initialize_c100_application(
      children_postcode: postcode_fixture
    )
  end

  def presence_or_default(attribute, default)
    attribute.presence || default
  end

  def upload_bypass_document(document_key)
    file_path = Rails.root.join('features/support/sample_file/image.jpg')

    document = DocumentUpload.new(
      File.open(file_path),
      document_key:,
      content_type: 'application/pdf',
      filename: 'document.pdf',
    )

    document.upload!(document_key:, collection_ref: c100_application.files_collection_ref)
  end

  # If there is already a court assigned, we maintain it
  def find_or_initialize_court
    c100_application.court || Court.find_by(slug: slug_fixture) || Court.new(court_fixture)
  end

  def find_or_create_people
    [Child, Applicant, Respondent].each do |klass|
      klass.find_or_initialize_by(c100_application_id: c100_application.id).tap do |record|
        record.update(first_name: record.type, last_name: 'Test') unless record.persisted?
      end
    end
  end

  def postcode_fixture
    'MK9 2DT'.freeze
  end

  def slug_fixture
    'milton-keynes-county-court-and-family-court'.freeze
  end

  def court_fixture
    {
      "slug" => slug_fixture,
      "name" => "Milton Keynes County Court and Family Court",
      "email" => "family@miltonkeynes.countycourt.gsi.gov.uk",
      "gbs" => "Y610",
      "cci_code" => 388,
      "address" => {
        "town" => "Central Milton Keynes",
        "postcode" => "MK9 2DT",
        "address_lines" => ["351 Silbury Boulevard", "Witan Gate East"],
      },
    }
  end

  def presence_or_default(attribute, default)
    attribute.presence || default
  end

  def upload_bypass_document(document_key)
    file_path = Rails.root.join('features/support/sample_file/image.jpg')

    document = DocumentUpload.new(
      File.open(file_path),
      document_key:,
      content_type: 'application/pdf',
      filename: 'document.pdf',
    )

    document.upload!(document_key:, collection_ref: c100_application.files_collection_ref)
  end

  # :nocov:
end
