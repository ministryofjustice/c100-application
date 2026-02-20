class ApplicantRelationshipPage < BasePage
  set_url '/steps/shared/relationship'

  section :content, '#main-content' do
    element :header, 'h1', text: 'relationship to'
    element :relation_father, "input#steps-shared-relationship-form-relation-father-field", visible: false
    element :relation_mother, "input#steps-shared-relationship-form-relation-mother-field", visible: false
    element :relation_other, "input#steps-shared-relationship-form-relation-other-field", visible: false
    element :continue_button, "button", text: "Continue"
  end

  def submit_relationship(relation)
    case relation.downcase
    when 'father'
      content.relation_father.click
    when 'mother'
      content.relation_mother.click
    else
      content.relation_other.click
    end
    content.continue_button.click
  end

  def submit(relationship)
    submit_relationship(relationship)
  end

  def continue_without_selecting
    content.continue_button.click
  end
end