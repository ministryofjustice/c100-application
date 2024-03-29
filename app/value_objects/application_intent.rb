class ApplicationIntent < ValueObject
  VALUES = [
    NEW = new(:new),
    CONTINUE = new(:continue),
  ].freeze

  def self.values
    VALUES
  end

  def new?
    value == :new
  end

  def continue?
    value == :continue
  end
end
