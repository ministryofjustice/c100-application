module C100App
  class MiamDecisionTree < BaseDecisionTree
    def destination
      return next_step if next_step

      case step_name
      when :miam_acknowledgement
        edit(:attended)
      when :miam_attended
        after_miam_attended
      when :miam_exemption_claim
        after_miam_exemption_claim
      when :miam_certification
        after_miam_certification
      when :certification_upload
        show('/steps/safety_questions/start')
      else
        raise InvalidStep, "Invalid step '#{as || step_params}'"
      end
    end

    private

    def after_miam_exemption_claim
      if question(:miam_exemption_claim).yes?
        edit('/steps/miam_exemptions/domestic')
      else
        show('/steps/miam_exemptions/exit_page')
      end
    end

    def after_miam_attended
      if question(:miam_attended).yes?
        edit(:certification)
      else
        edit(:exemption_claim)
      end
    end

    def after_miam_certification
      if question(:miam_certification).yes?
        edit(:certification_upload)
      else
        show(:certification_exit)
      end
    end
  end
end
