class BlankDateInputValidator < ActiveModel::EachValidator
  def validate_each(record, input_attribute, value)
    return if value == [nil, 0, 0, 0] || value.nil?
    attribute = input_attribute.to_s.delete_prefix('input_').to_sym
    record.errors.add(attribute, 'Cannot have a date of birth and also "I don\'t know their date of birth"')
  end
end
