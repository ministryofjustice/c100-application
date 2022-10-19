class ProtectionExemptions < ValueObject
  VALUES = [
    AUTHORITY_INVOLVEMENT = [
      new(:misc_authority_enquiring),
      new(:misc_authority_protection_order),
    ].freeze,

    PROTECTION_NONE = new(:misc_protection_none)
  ].flatten.freeze

  # :nocov:
  def self.values
    VALUES
  end
  # :nocov:
end
