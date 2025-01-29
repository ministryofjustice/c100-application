class ContactDetails < ValueObject
  VALUES = [
    ADDRESS = new(:address),
    EMAIL = new(:email),
    PHONE_NUMBER = new(:phone_number),
  ].freeze

  def self.values
    VALUES
  end

  def long_name
    {
      address: 'Current address',
      email: 'Email',
      phone_number: 'Phone number',
    }[to_sym]
  end
end
