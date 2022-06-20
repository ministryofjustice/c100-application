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

  def long_name
    {
      address: 'Current address',
      email: 'Email',
      mobile: 'Mobile phone number',
      home_phone: 'Home phone number'
    }[to_sym]
  end
end
