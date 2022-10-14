class UrgencyExemptions < ValueObject
  VALUES = [
    RISK_APPLICANT = new(:misc_risk_applicant),
    UNREASONABLE_HARDSHIP = new(:misc_unreasonable_hardship),
    RISK_CHILDREN = new(:misc_risk_children),
    RISK_UNLAWFUL_REMOVAL_RETENTION = new(:misc_risk_unlawful_removal_retention),
    MISCARRIAGE_JUSTICE = new(:misc_miscarriage_justice),
    IRRETRIEVABLE_PROBLEMS = new(:misc_irretrievable_problems),
    INTERNATIONAL_PROCEEDINGS = new(:misc_international_proceedings),

    URGENCY_NONE = new(:misc_urgency_none)
  ].flatten.freeze

  # :nocov:
  def self.values
    VALUES
  end
  # :nocov:
end
