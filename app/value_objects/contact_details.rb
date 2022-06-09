class ContactDetails < ValueObject
  VALUES = [
    ADDRESS = new(:address),
    EMAIL = new(:email),
    MOBILE = new(:mobile),
    HOME_PHONE = new(:home_phone),
  ].freeze

  def self.values
    VALUES
  end
end
