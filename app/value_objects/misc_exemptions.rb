class MiscExemptions < ValueObject
  VALUES = [
    WITHOUT_NOTICE = new(:misc_without_notice),

    GROUP_MIAM_ACCESS = new(:group_miam_access),
    MIAM_ACCESS = [
      new(:miam_access_disabled_facilities),
      new(:miam_access_appointment),
      new(:miam_access_mediator_nearby),
    ].freeze,

    APPLICANT_UNDER_AGE = new(:misc_applicant_under_age),

    MISC_NONE = new(:misc_none)
  ].flatten.freeze

  # :nocov:
  def self.values
    VALUES
  end
  # :nocov:
end
