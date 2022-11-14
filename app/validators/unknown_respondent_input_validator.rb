class UnknownRespondentInputValidator < ActiveModel::EachValidator
  def validate_each(record, input_attribute, value)
    return if value.nil? || value.blank?

    unknown_label = I18n.t(".dictionary.PERSONAL_CONTACT_FIELDS.#{input_attribute}_unknown_options.true")
    label_text = I18n.t(".dictionary.PERSONAL_CONTACT_FIELDS.#{input_attribute}")
    record.errors.add(input_attribute, "Cannot select '#{unknown_label}' and input '#{label_text}'")
  end
end
