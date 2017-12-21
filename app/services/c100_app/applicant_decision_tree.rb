module C100App
  class ApplicantDecisionTree < BaseDecisionTree
    def destination
      return next_step if next_step

      case step_name
      when :user_type
        edit('/steps/help_with_fees/help_paying')
      when :add_another_name
        edit(:names)
      when :names_finished
        edit(:personal_details, id: next_applicant_id)
      when :personal_details
        edit(:relationship, id: record, child_id: first_child_id)
      when :relationship
        children_relationships
      when :contact_details
        after_contact_details
      else
        raise InvalidStep, "Invalid step '#{as || step_params}'"
      end
    end

    private

    def after_contact_details
      if next_applicant_id
        edit(:personal_details, id: next_applicant_id)
      else
        edit('/steps/respondent/names')
      end
    end

    def children_relationships
      if next_child_id
        edit(:relationship, id: record.applicant, child_id: next_child_id)
      else
        edit(:contact_details, id: record.applicant)
      end
    end

    def next_applicant_id
      next_record_id(c100_application.applicant_ids)
    end

    def next_child_id
      next_record_id(c100_application.child_ids, current: record.child)
    end

    def first_child_id
      c100_application.child_ids.first
    end
  end
end
