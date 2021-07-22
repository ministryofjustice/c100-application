module Summary
  class AnswersGroup
    include Helpers

    attr_reader :name, :change_path

    def initialize(name, answers, params = {})
      @name = name
      @answers = answers
      @change_path = params[:change_path]
    end

    def answers
      @answers.select(&:show?)
    end

    def show?
      answers.any?
    end

    def show_change_link?
      change_path.present?
    end

    def to_partial_path
      'steps/completion/shared/answers_group'
    end

    def to_hash
      additional_data({ name: name, answers: answers.map(&:to_hash) })
    end
  end
end
