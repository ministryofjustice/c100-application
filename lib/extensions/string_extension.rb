module StringExtension
  def true?
    /(true|t|yes|y|1)$/i.match(to_s).present?
  end

  def false?
    to_s.strip.empty? || /(false|f|no|n|0)$/i.match(to_s).present?
  end

  def to_bool
    return true  if true?
    return false if false?
    raise ArgumentError, "Invalid value for Boolean: `#{self}`"
  end
end
