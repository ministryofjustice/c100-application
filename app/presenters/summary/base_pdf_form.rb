module Summary
  class BasePdfForm
    attr_reader :c100_application

    def initialize(c100_application)
      @c100_application = c100_application
    end

    def template
      'steps/completion/summary/show.pdf'
    end

    # :nocov:
    def name
      raise 'implement in subclasses'
    end

    def sections
      raise 'implement in subclasses'
    end

    # If needed, override in subclasses to change the format or to hide it completely.
    def page_number
      '[page]/[topage]'
    end
    # :nocov:

    # If needed, specify in subclasses a PDF file to be used 'as it is', appended
    # at the end of the generated PDF (this file will go after the `#sections` call).
    def raw_file_path
      nil
    end

    def to_hash
      sections.map do |section|
        if section.is_a?(Array)
          section.map(&:to_hash)
        else
          section.to_hash
        end
      end
    end
  end
end
