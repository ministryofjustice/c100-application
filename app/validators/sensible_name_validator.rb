class SensibleNameValidator < ActiveModel::EachValidator
  REGEX = /^[a-zA-Z '-]+$/i.freeze

  def validate_each(record, attribute, value)
    return if value.nil?

    record.errors.add(attribute, :invalid_name) unless value.match(REGEX)
  end
end
