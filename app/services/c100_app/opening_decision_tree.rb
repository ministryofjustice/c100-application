module C100App
  class OpeningDecisionTree < BaseDecisionTree
    def destination
      return next_step if next_step

      case step_name
      when :start_or_continue
        after_start_or_continue
      when :sign_in_or_create_account
        after_sign_in_or_create_account
      when :continue_application
        after_continue_application
      when :research_consent
        check_if_valid_court
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

    def after_sign_in_or_create_account
      if question(:has_myhmcts_account).yes?
        show(:my_hmcts_manage_case)
      else
        show(:my_hmcts_create_account)
      end
    end

    def after_continue_application
      if(question(:platform, c100_application, ApplicationPlatform).my_hmcts?)
        show(:my_hmcts_manage_case)
      else
        show(:redirect_to_login)
      end
    end

    def after_start_or_continue
      # scenario 1
      if question(:start_or_continue, c100_application, ApplicationIntent).new? &&
         question(:is_legal_representative).yes?
         check_court_and_send_to_court_based_destination

      # scenario 2
      elsif question(:start_or_continue, c100_application, ApplicationIntent).continue? &&
            question(:is_legal_representative).yes?
        edit(:continue_application)
      
      # # scenario 3
      # elsif question(:start_or_continue, c100_application, ApplicationIntent).new? &&
      #       question(:is_legal_representative).no?
      #   check_if_valid_court(send_to_sign_in(send_to_my_hmcts_guidance))

      else
        edit(:sign_in_or_create_account)
      end
    end

    def check_court_and_send_to_court_based_destination
      court = CourtPostcodeChecker.new.court_for(children_postcode)

      return show(:no_court_found) unless 
      court
      c100_application.update!(court: court)

      send_to_court_based_destination
    # `CourtPostcodeChecker` and `Court` already log any potential exceptions
    rescue StandardError
      show(:error_but_continue)
    end

    def send_to_court_based_destination
      if show_research_consent?
        edit(:research_consent)
      elsif eligable_court
        edit(:sign_in_or_create_account)
      else
        edit(:consent_order)
      end
    end

    def send_to_my_hmcts_guidance
      url = 'https://apply-to-court-about-child-arrangements-c100.service.gov.uk/complete-your-application-guidance'
      url
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

    def eligable_court
      c100_application.court.id.in? %w[
        swansea-civil-justice-centre
        gloucester-and-cheltenham-county-and-family-court
        coventry-combined-court-centre
        newcastle-civil-family-courts-and-tribunals-centre
        peterborough-combined-court-centre
        east-london-family-court
      ]
    end
  end
end
