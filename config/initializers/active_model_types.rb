class HashValueType < ActiveModel::Type::Value
  def cast(value)
    value.is_a?(Hash) ? value : nil
  end
end

class StrictBooleanType < ActiveModel::Type::Boolean
  def cast(value)
    case value
    when true, "true", "1", 1
      true
    when false, "false", "0", 0
      false
    end
  end
end

class SymbolType < ActiveModel::Type::Value
  def cast(value)
    value&.to_sym
  end
end

class YesNoType < ActiveModel::Type::Value
  def cast(value)
    case value
    when :string, :symbol
      GenericYesNo.new(value)
    when GenericYesNo
      value
    end
  end
end

class YesNoUnknownType < ActiveModel::Type::Value
  def cast(value)
    case value
    when :string, :symbol
      GenericYesNoUnknown.new(value)
    when GenericYesNoUnknown
      value
    end
  end
end

class StringArrayType < ActiveModel::Type::Value
  def cast(value)
    case value
    when Array
      value.map(&:to_s)
    when nil
      []
    else
      [value.to_s]
    end
  end
end

class StrippedStringType < ActiveModel::Type::Value
  def cast(value)
    value.to_s.strip
  end
end

class SplitAddressType < ActiveModel::Type::Value
  TOKEN_SEPARATOR = '|'.freeze
  def cast(value)
    return if value.nil?

    tokens = value.to_s.split(TOKEN_SEPARATOR)
    return if tokens.empty?

    {
      address_line_1: tokens[0],
      address_line_2: tokens[1],
      address_line_3: tokens[2],
      town: tokens[3],
      country: tokens[4],
      postcode: tokens[5],
    }
  end
end

class GenderAttributeType < ActiveModel::Type::Value
  def cast(value)
    case value
    when String, Symbol
      Gender.new(value)
    when Gender
      value
    end
  end
end

class MultiParamDateType < ActiveModel::Type::Date
  def cast(value)
    return value unless value.is_a?(Array)

    set_values = value.values_at(1, 2, 3)
    return if set_values.any?(&:nil?)
    return if set_values.all?(&:zero?)

    Date.new(*set_values)
  rescue ArgumentError
    nil
  end
end


ActiveModel::Type.register(:hash_value, HashValueType)
ActiveModel::Type.register(:boolean, StrictBooleanType)
ActiveModel::Type.register(:symbol, SymbolType)
ActiveModel::Type.register(:yes_no, YesNoType)
ActiveModel::Type.register(:yes_no_unknown, YesNoUnknownType)
ActiveModel::Type.register(:string_array, StringArrayType)
ActiveModel::Type.register(:stripped_string, StrippedStringType)
ActiveModel::Type.register(:split_address, SplitAddressType)
ActiveModel::Type.register(:gender_attribute, GenderAttributeType)
ActiveModel::Type.register(:multi_param_date, MultiParamDateType)
