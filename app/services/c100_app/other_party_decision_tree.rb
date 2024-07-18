module C100App
  class OtherPartyDecisionTree < PeopleDecisionTree
    # rubocop:disable Metrics/MethodLength
    def destination
      return next_step if next_step

      case step_name
      when :add_another_name
        edit(:names)
      when :names_finished
        if PrivacyChange.changes_apply?
          edit("/steps/other_party/children_cohabit_other", id: next_party_id)
        else
          edit(:personal_details, id: next_party_id)
        end
      when :personal_details
        edit_first_child_relationships
      when :relationship
        children_relationships
      when :address_details
        after_address_details
      when :cohabit_with_other
        after_cohabit_with_other
      when :privacy_preferences
        after_privacy_preferences
      else
        raise InvalidStep, "Invalid step '#{as || step_params}'"
      end
    end
    # rubocop:enable Metrics/MethodLength

    private

    def after_cohabit_with_other
      if record.person.reload.cohabit_with_other == 'yes'
        edit(:privacy_preferences, id: record.person)
      else
        after_privacy_preferences
      end
    end

    def after_privacy_preferences
      edit(:personal_details, id: record.person)
    end

    def after_address_details
      if PrivacyChange.changes_apply? && next_party_id
        edit("/steps/other_party/children_cohabit_other", id: next_party_id)
      elsif next_party_id
        edit(:personal_details, id: next_party_id)
      else
        edit('/steps/children/residence', id: first_child_id)
      end
    end

    def next_party_id
      next_record_id(c100_application.other_party_ids)
    end
  end
end
