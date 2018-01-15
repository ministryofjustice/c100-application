module C100App
  class PetitionDecisionTree < BaseDecisionTree
    def destination
      return next_step if next_step

      case step_name
      when :orders
        show(:playback)
      else
        raise InvalidStep, "Invalid step '#{as || step_params}'"
      end
    end
  end
end
