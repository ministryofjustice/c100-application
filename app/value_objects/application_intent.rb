class ApplicationIntent < ValueObject
  VALUES = [
    NEW = new(:new),
    CONTINUE = new(:continue),
  ].freeze

  def self.values
    VALUES
  end
end
