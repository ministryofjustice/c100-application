module Summary
  class Separator
    include Helpers

    attr_reader :title, :i18n_opts

    def initialize(title, i18n_opts = {})
      @title = title
      @i18n_opts = i18n_opts
    end

    class << self
      def not_applicable
        new(:not_applicable)
      end
    end

    def show?
      true
    end

    def to_partial_path
      'steps/completion/shared/separator'
    end

    def to_hash
      additional_data({ title: title })
    end
  end
end
