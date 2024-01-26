class ApplicationFulfilmentValidator < ActiveModel::Validator
  include Rails.application.routes.url_helpers

  def validate(record)
    validations.each do |validation|
      if (attribute, error, change_path = validation.call(record))
        record.errors.add(attribute, error, change_path:)
      end
    end
  end

  private

  # Individual validations to be added here
  # Errors, when more than one, will maintain this order
  #
  def validations
    [
      generate_petition_validation,
      generate_validation(:children, edit_steps_children_names_path(id: '')),
      generate_validation(:applicants, edit_steps_applicant_names_path(id: '')),
      generate_validation(:respondents, edit_steps_respondent_names_path(id: '')),
      generate_validation(:payment_type, edit_steps_application_payment_path, :present?),
      generate_document_validation(:miam_certificate, edit_steps_miam_certification_upload_path,
                                   [:consent_order?, :child_protection_cases?, :miam_exemption_claim?]),
      generate_document_validation(:draft_consent_order, edit_steps_opening_consent_order_upload_path,
                                   :consent_order?, invert: true)
    ]
  end

  def generate_validation(attribute_type, path, method = :any?)
    ->(record) { [attribute_type, :blank, path] unless record.send(attribute_type).send(method) }
  end

  def generate_document_validation(document_type, path, checks, invert: false)
    lambda do |record|
      unless record.document(document_type) || additional_checks(record, Array(checks), invert)
        [:files_collection_ref, :blank, path]
      end
    end
  end

  def generate_petition_validation
    ->(record) { [:orders, :blank, edit_steps_petition_orders_path] unless record.has_petition_orders? }
  end

  def additional_checks(record, checks, invert)
    checks.map { |check| record.send(check) }.send(invert ? :none? : :any?)
  end
end
