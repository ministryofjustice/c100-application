class ApplicationPlatform < ValueObject
  VALUES = [
    MY_HMCTS = new(:my_hmcts),
    GOV_UK = new(:gov_uk),
  ].freeze

  def self.values
    VALUES
  end

  def my_hmcts?
    value == :my_hmcts
  end

  def gov_uk?
    value == :gov_uk
  end
end
