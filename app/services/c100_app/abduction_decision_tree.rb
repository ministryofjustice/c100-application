module C100App
  class AbductionDecisionTree < BaseDecisionTree
    def destination
      return next_step if next_step

      case step_name
      when :children_have_passport
        after_children_have_passport
      when :international_risk
        after_international_risk
      when :previous_attempt
        after_previous_attempt
      when :previous_attempt_details
        edit(:risk_details)
      when :risk_details
        edit('/steps/safety_questions/substance_abuse')
      else
        raise InvalidStep, "Invalid step '#{as || step_params}'"
      end
    end

    private

    def after_children_have_passport
      if selected?(:children_have_passport)
        edit(:international)
      else
        edit(:previous_attempt)
      end
    end

    def after_international_risk
      if selected?(:international_risk)
        edit(:previous_attempt)
      else
        edit(:risk_details)
      end
    end

    def after_previous_attempt
      if selected?(:previous_attempt)
        edit(:previous_attempt_details)
      else
        edit(:risk_details)
      end
    end
  end
end
