class AdrExemptions < ValueObject
  VALUES = [
    PREVIOUS_ADR = [
      new(:misc_previous_attendance),
      new(:misc_ongoing_attendance),
      new(:misc_existing_proceedings_attendance),
    ].freeze,

    PREVIOUS_MIAM = [
      new(:misc_previous_exemption),
      new(:misc_existing_proceedings_exemption),
    ].freeze,

    ADR_NONE = new(:misc_adr_none)
  ].flatten.freeze

  # :nocov:
  def self.values
    VALUES
  end
  # :nocov:
end
