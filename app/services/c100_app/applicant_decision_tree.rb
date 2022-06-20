module C100App
  class ApplicantDecisionTree < PeopleDecisionTree
    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
    def destination
      return next_step if next_step

      case step_name
      when :add_another_name
        edit(:names)
      when :names_finished
        edit(:privacy_known, id: next_applicant_id)
      when :privacy_known
        edit(:privacy_preferences)
      when :privacy_preferences
        show(:privacy_summary)
      when :privacy_summary
        edit(:personal_details)
      when :personal_details
        after_personal_details
      when :under_age
        edit_first_child_relationships
      when :relationship
        after_relationship
      when :address_details
        edit_contact_details
      when :contact_details
        after_contact_details
      when :has_solicitor
        after_has_solicitor
      else
        raise InvalidStep, "Invalid step '#{as || step_params}'"
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength

    private

    def after_personal_details
      if record.reload.dob > 18.years.ago
        edit(:under_age, id: record)
      else
        edit_first_child_relationships
      end
    end

    def after_contact_details
      if next_applicant_id
        edit(:privacy_known, id: next_applicant_id)
      else
        edit(:has_solicitor)
      end
    end

    def after_relationship
      rules = Permission::RelationshipRules.new(record)

      # Non-parents - permission to be decided
      if rules.permission_undecided?
        edit('/steps/permission/question', question_name: :parental_responsibility, relationship_id: record)
      else
        children_relationships
      end
    end

    def after_has_solicitor
      if question(:has_solicitor).yes?
        edit('/steps/solicitor/personal_details')
      else
        edit('/steps/respondent/names')
      end
    end

    def next_applicant_id
      next_record_id(c100_application.applicant_ids)
    end
  end
end
