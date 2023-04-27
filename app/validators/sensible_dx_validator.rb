class SensibleDxValidator < ActiveModel::EachValidator
  REGEX = /^[0-9-]+$/i

  def validate_each(record, attribute, value)
    return if value.nil? || value == ''

    record.errors.add(attribute, :invalid) unless value.match(REGEX)
  end
end
