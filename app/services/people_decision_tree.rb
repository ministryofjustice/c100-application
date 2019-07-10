class PeopleDecisionTree < BaseDecisionTree
  private

  def after_personal_details(age_check: true)
    if age_check && dob_under_age?
      edit(:under_age, id: record)
    else
      edit_first_child_relationships
    end
  end

  def dob_under_age?
    record.reload.dob > 18.years.ago
  end

  def edit_first_child_relationships
    edit(:relationship, id: record, child_id: first_minor_id)
  end

  def children_relationships
    current_person = record.person

    if next_child_id
      edit(:relationship, id: current_person, child_id: next_child_id)
    elsif show_address_lookup?
      edit('/steps/address/lookup', id: current_person)
    else
      edit(:address_details, id: current_person)
    end
  end

  def edit_contact_details
    edit(:contact_details, id: record)
  end

  def next_child_id
    next_record_id(c100_application.minor_ids, current: record.minor)
  end

  # Minors collection include `Child` and `OtherChild` types.
  def first_minor_id
    c100_application.minor_ids.first
  end

  # Children collection only include `Child` type. This should be used in
  # the residence loop, as we only need the residence of the main children.
  def first_child_id
    c100_application.child_ids.first
  end

  # If the address has already been entered, do not take the user again
  # through the postcode lookup and address selection steps.
  def show_address_lookup?
    return false if record.person.address_unknown?
    record.person.address_line_1.blank?
  end
end
