module C100App
  class ApplicationDecisionTree < BaseDecisionTree # rubocop:disable Metrics/ClassLength
    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def destination
      return next_step if next_step

      case step_name
      when :previous_proceedings
        after_previous_proceedings
      when :court_proceedings
        record.relation.eql?(Relation::OTHER.to_s) ? edit(:permission_sought) : edit(:existing_court_order)
      when :existing_court_order
        after_existing_court_order
      when :existing_court_order_uploadable
        after_existing_court_order_uploadable
      when :existing_court_order_upload
        edit(:urgent_hearing)
      when :urgent_hearing
        after_urgent_hearing
      when :urgent_hearing_details
        edit(:without_notice)
      when :without_notice
        after_without_notice
      when :without_notice_details
        record.relation.eql?(Relation::OTHER.to_s) ? edit(:litigation_capacity) : start_international_journey
      when :permission_sought
        after_permission_sought
      when :permission_details
        edit(:details)
      when :application_details
        record.relation.eql?(Relation::OTHER.to_s) ? edit(:existing_court_order) : edit(:litigation_capacity)
      when :litigation_capacity
        after_litigation_capacity
      when :litigation_capacity_details
        start_attending_court_journey
      when :submission
        after_submission_type
      when :payment
        edit(:check_your_answers)
      when :declaration
        proceed_to_payment
      else
        raise InvalidStep, "Invalid step '#{as || step_params}'"
      end
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    private

    def after_previous_proceedings
      if question(:children_previous_proceedings).yes?
        edit(:court_proceedings)
      else
        record.relation.eql?(Relation::OTHER.to_s) ? edit(:permission_sought) : edit(:existing_court_order)
      end
    end

    def after_existing_court_order
      if question(:existing_court_order).yes?
        edit(:existing_court_order_uploadable)
      else
        edit(:urgent_hearing)
      end
    end

    def after_existing_court_order_uploadable
      if question(:existing_court_order_uploadable).yes?
        edit(:existing_court_order_upload)
      else
        edit(:urgent_hearing)
      end
    end

    def after_urgent_hearing
      if question(:urgent_hearing).yes?
        edit(:urgent_hearing_details)
      else
        edit(:without_notice)
      end
    end

    def after_without_notice
      if question(:without_notice).yes?
        edit(:without_notice_details)
      else
        record.relation.eql?(Relation::OTHER.to_s) ? edit(:litigation_capacity) : start_international_journey
      end
    end

    def after_permission_sought
      if question(:permission_sought).yes?
        # Applicant already has permission or applied separately
        edit(:details)
      else
        # Applicant is seeking permission now
        edit(:permission_details)
      end
    end

    def after_litigation_capacity
      if question(:reduced_litigation_capacity).yes?
        edit(:litigation_capacity_details)
      else
        start_attending_court_journey
      end
    end

    def after_submission_type
      if c100_application.receipt_email.present?
        show(:receipt_email_check)
      else
        edit(:payment)
      end
    end

    def start_international_journey
      edit('/steps/international/resident')
    end

    def start_attending_court_journey
      edit('/steps/attending_court/intermediary')
    end

    def proceed_to_payment
      PaymentsFlowControl.new(c100_application).payment_url
    end

    def record
      @record || c100_application.relationships.find { |r| r.person.type == "Applicant" }
    end
  end # rubocop:enable Metrics/ClassLength
end
