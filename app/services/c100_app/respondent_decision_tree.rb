module C100App
  class RespondentDecisionTree < PeopleDecisionTree
    def destination
      return next_step if next_step

      case step_name
      when :add_another_name
        edit(:names)
      when :names_finished
        edit(:personal_details, id: next_respondent_id)
      when :personal_details
        after_personal_details(age_check: false)
      when :under_age
        edit_first_child_relationships
      when :relationship
        children_relationships
      when :address_details
        edit_contact_details
      when :contact_details
        after_contact_details
      when :has_other_parties
        after_has_other_parties
      else
        raise InvalidStep, "Invalid step '#{as || step_params}'"
      end
    end

    private

    def after_contact_details
      if next_respondent_id
        edit(:personal_details, id: next_respondent_id)
      else
        edit(:has_other_parties)
      end
    end

    def after_has_other_parties
      if question(:has_other_parties).yes?
        edit('/steps/other_party/names')
      else
        edit('/steps/children/residence', id: first_child_id)
      end
    end

    def dob_under_age?
      # Respondents, unlike Applicants, can have an 'unknown' DoB and they can fill
      # an 'approximate age or year born' free input text. The prototype does some fancy
      # stuff to try to come up with a valid date/age from the text field, but for now,
      # I will leave out that functionality as there are more important things to do!
      record.reload.dob.present? && (record.dob > 18.years.ago)
    end

    def next_respondent_id
      next_record_id(c100_application.respondent_ids)
    end
  end
end
