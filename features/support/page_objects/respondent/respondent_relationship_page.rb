class RespondentRelationshipPage < BasePage
  set_url_matcher %r{/steps/respondent/relationship/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'relationship to'
    element :relation_father, "input#steps-shared-relationship-form-relation-father-field", visible: false
    element :relation_mother, "input#steps-shared-relationship-form-relation-mother-field", visible: false
    element :relation_other, "input#steps-shared-relationship-form-relation-other-field", visible: false
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
    click_continue_button
  end

  def submit(relationship)
    submit_relationship(relationship)
  end
end
