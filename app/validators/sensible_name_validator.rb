class SensibleNameValidator < ActiveModel::EachValidator

  ILLEGAL_CHARS = '\<>.,?[]=)(*&£^%$#~{}+@!±§|"/:;`'.freeze
  REGEX = /[#{ILLEGAL_CHARS.gsub(/./) { |char| "\\#{char}" }}]/.freeze

  def validate_each(record, attribute, value)
    return if value.nil?

    record.errors.add(attribute, :invalid_name) if value.match(REGEX)
  end

end
