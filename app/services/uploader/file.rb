class Uploader
  class File < ApiClient
    EXPIRES_IN = 300 # seconds

    attr_reader :key

    def initialize(key)
      super
      @key = key
    end

    def name
      key.split('/').last
    end

    # Allow two File objects to be compared
    def ==(other)
      key == other.key
    end

    def hash
      key.hash
    end
  end
end
