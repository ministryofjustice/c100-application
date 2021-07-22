module Summary
  class Partial
    include Helpers

    attr_reader :name, :ivar

    def initialize(name, ivar = nil)
      @name = name
      @ivar = ivar
    end

    class << self
      def page_break
        new(:page_break)
      end

      def blank_page
        new(:blank_page)
      end

      def row_blank_space
        new(:row_blank_space)
      end

      def horizontal_rule
        new(:horizontal_rule)
      end
    end

    def show?
      true
    end

    def to_partial_path
      "steps/completion/shared/#{name}"
    end

    def to_hash
      additional_data({ name: name, ivar: (ivar || {}).to_hash })
    end
  end
end
