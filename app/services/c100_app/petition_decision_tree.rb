module C100App
  class PetitionDecisionTree < BaseDecisionTree
    def destination
      return next_step if next_step

      case step_name
      when :orders
        after_orders
      when :other_issue
        playback_step
      else
        raise InvalidStep, "Invalid step '#{as || step_params}'"
      end
    end

    private

    def after_orders
      if checked?(:other)
        edit(:other_issue)
      else
        playback_step
      end
    end

    def playback_step
      show(:playback)
    end
  end
end
