module Summary
  class BaseAnswer
    include Helpers

    attr_reader :question, :value, :show, :change_path, :i18n_opts

    DEFAULT_OPTIONS = { default: nil, show: nil, change_path: nil, i18n_opts: {} }.freeze

    def initialize(question, value, *args)
      options = extract_supported_options!(args)

      @question = question
      @value = value || options[:default]
      @show = options[:show]
      @change_path = options[:change_path]
      @i18n_opts = options[:i18n_opts]
    end

    def show?
      show.presence || value?
    end

    def value?
      value.present?
    end

    def show_change_link?
      change_path.present?
    end

    # Used by Rails to determine which partial to render
    # :nocov:
    def to_partial_path
      raise 'implement in subclasses'
    end
    # :nocov:

    def to_hash
      additional_data({ question: question, value: parsed_value })
    end

    private

    def extract_supported_options!(args)
      options = DEFAULT_OPTIONS.merge(args.extract_options!)
      options.assert_valid_keys(DEFAULT_OPTIONS.keys)
      options
    end

    def parsed_value
      if value.is_a?(GenericYesNo)
        value.value
      else
        value
      end
    end
  end
end
