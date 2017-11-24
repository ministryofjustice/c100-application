module StringExtension
  def true?
    /(true|t|yes|y|1)$/i.match(to_s).present?
  end

  def false?
    to_s.strip.empty? || /(false|f|no|n|0)$/i.match(to_s).present?
  end
end
