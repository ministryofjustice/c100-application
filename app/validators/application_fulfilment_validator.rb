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
      generate_miam_validation_reasons,
      generate_miam_validation_details,
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

  def generate_miam_validation_reasons
    lambda { |record|
      [:attach_evidence, :blank,
       edit_steps_miam_exemptions_exemption_reasons_path] unless record.attach_evidence.present? ||
                                                                 record.consent_order == 'yes' ||
                                                                 has_other_skip_exemptions?(record) ||
                                                                 record.document(:miam_certificate) ||
                                                                 record.child_protection_cases == 'yes'
    }
  end

  def generate_miam_validation_details
    lambda { |record|
      [:attach_evidence, :blank,
       edit_steps_miam_exemptions_exemption_details_path] if record.miam_exemption_claim == 'yes' &&
                                                             record.exemption_details.blank? &&
                                                             has_domestic_or_only_misc(record)
    }
  end

  def has_domestic_or_only_misc(record)
    exemptions = record.miam_exemption.misc
    return true if record.miam_exemption.domestic.exclude?("misc_domestic_none")
    return true if %w[misc_access misc_access2 misc_access3].any? do |misc|
      exemptions.include?(misc)
    end
    return true if only_misc_selected?(exemptions) && other_group_check(record)

    false
  end

  def has_other_skip_exemptions?(record) # rubocop:disable Metrics/PerceivedComplexity
    return false unless record&.miam_exemption&.misc

    exemptions = record.miam_exemption.misc

    return false if record.miam_exemption.domestic.exclude?("misc_domestic_none") && check_if_misc_skip_not_selected(exemptions)

    return false if only_misc_selected?(exemptions) && other_group_check(record) && check_if_misc_skip_not_selected(exemptions)

    true
  end # rubocop:enable Metrics/PerceivedComplexity

  def only_misc_selected?(exemptions)
    %w[misc_without_notice misc_applicant_under_age misc_access4].any? do |misc|
      exemptions.include?(misc)
    end
  end

  def check_if_misc_skip_not_selected(exemptions)
    %w[misc_access misc_access2 misc_access3].none? { |misc| exemptions.include?(misc) }
  end

  def other_group_check(record)
    groups = [:protection, :urgency, :adr]
    groups.all? { |group| record.miam_exemption.send(group).include?("misc_#{group}_none") }
  end

  def additional_checks(record, checks, invert)
    checks.map { |check| record.send(check) }.send(invert ? :none? : :any?)
  end
end
