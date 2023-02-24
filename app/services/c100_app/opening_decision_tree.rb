module C100App
  class OpeningDecisionTree < BaseDecisionTree
    def destination
      return next_step if next_step

      case step_name
      when :children_postcode
        check_if_court_is_valid
      when :research_consent
        check_if_my_hmcts_eligable_court
      when :my_hmcts
        after_my_hmcts
      when :consent_order
        after_consent_order
      when :consent_order_upload
        show(:consent_order_sought)
      when :child_protection_cases
        after_child_protection_cases
      else
        raise InvalidStep, "Invalid step '#{as || step_params}'"
      end
    end

    private

    def children_postcode
      step_params.fetch(:children_postcode)
    end

    def check_if_my_hmcts_eligable_court
      # if eligable_court
      # edit(:my_hmcts)
      # else
      edit(:consent_order)
      # end
    end

    def check_if_court_is_valid
      court = CourtPostcodeChecker.new.court_for(children_postcode)

      if court
        c100_application.update!(court: court)

        if show_research_consent?
          edit(:research_consent)
        else
          check_if_my_hmcts_eligable_court
        end
      else
        show(:no_court_found)
      end
    # `CourtPostcodeChecker` and `Court` already log any potential exceptions
    rescue StandardError
      show(:error_but_continue)
    end

    def after_my_hmcts
      # if question(:use_my_hmcts).yes?
      # show(:redirect_to_my_hmcts)
      # else
      edit(:consent_order)
      # end
    end

    def after_consent_order
      if question(:consent_order).yes?
        edit(:consent_order_upload)
      else
        edit(:child_protection_cases)
      end
    end

    def after_child_protection_cases
      # If we know is a consent order, then it does not matter the answer
      # to this question, we bypass MIAM (jump to safety questions)
      return show('/steps/safety_questions/start') if question(:consent_order).yes?

      if question(:child_protection_cases).yes?
        show(:child_protection_info)
      else
        edit('/steps/miam/acknowledgement')
      end
    end

    def show_research_consent?
      ResearchSampler.candidate?(
        c100_application, Rails.configuration.x.opening.research_consent_weight
      )
    end

    # def eligable_court
    #   c100_application.court.id.in? %w[
    #     swansea-civil-justice-centre
    #     gloucester-and-cheltenham-county-and-family-court
    #     coventry-combined-court-centre
    #     newcastle-civil-family-courts-and-tribunals-centre
    #     peterborough-combined-court-centre
    #     east-london-family-court
    #   ]
    # end
  end
end
