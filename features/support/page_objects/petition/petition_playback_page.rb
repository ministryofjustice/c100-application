class PetitionPlaybackPage < BasePage
  set_url '/steps/petition/playback'

  section :content, '#main-content' do
    element :header, 'h1', text: 'What you’re asking the court to decide about the children?'
    element :child_arrangements_order, "p", text: "This is known as a Child Arrangements Order."
    element :specfic_issue_order, "p", text: "This is known as a Specific Issue Order."
    element :prohibited_steps_order, "p", text: "This is known as a Prohibited Steps Order."
    element :child_arrangements_home, 'li', text: 'Decide who they live with and when'
    element :child_arrangements_time, 'li', text: 'Decide how much time they spend with each person'
    element :group_prohibited_steps, 'li', text: 'Stop the other person doing something'
    element :prohibited_steps_names, 'li', text: 'Changing their names or surname'
    element :prohibited_steps_medical, 'li', text: 'Allowing medical treatment to be carried out on them'
    element :prohibited_steps_holiday, 'li', text: 'Taking them on holiday'
    element :prohibited_steps_moving, 'li', text: 'Relocating the children to a different area in England and Wales'
    element :prohibited_steps_moving_abroad, 'li', text: 'Relocating the children outside of England and Wales (including Scotland and Northern Ireland)'
    element :group_specific_issues, 'li', text: 'Resolve a specific issue'
    element :specific_issues_holiday, 'li', text: 'A specific holiday or arrangement'
    element :specific_issues_school, 'li', text: 'What school they’ll go to'
    element :specific_issues_religion, 'li', text: 'A religious issue'
    element :specific_issues_names, 'li', text: 'Changing their names or surname'
    element :specific_issues_medical, 'li', text: 'Medical treatment'
    element :specific_issues_moving, 'li', text: 'Relocating the children to a different area in England and Wales'
    element :specific_issues_moving_abroad, 'li', text: 'Relocating the children outside of England and Wales (including Scotland and Northern Ireland)'
    element :specific_issues_child_return, 'li', text: 'Returning the children to your care'
    element :continue_button, "a", text: "Continue"
  end

  def continue_to_next_step
    content.continue_button.click
  end
end