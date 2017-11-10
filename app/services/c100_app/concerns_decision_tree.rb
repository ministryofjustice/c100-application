module C100App
  class ConcernsDecisionTree < BaseDecisionTree
    def destination
      return next_step if next_step

      case step_name
      # TODO: Put decision logic here
      when :name
        show('/')
      else
        raise InvalidStep, "Invalid step '#{as || step_params}'"
      end
    end
  end
end
