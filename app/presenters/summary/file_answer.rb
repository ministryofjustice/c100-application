module Summary
  class FileAnswer < BaseAnswer

    def initialize(question, value, *args)
      super(question, value, *args)
      # debugger
    end

    def to_partial_path
      'steps/completion/shared/file_row'
    end
  end
end
