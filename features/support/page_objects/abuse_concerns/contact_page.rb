class ContactPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/abuse_concerns/contact'

  section :content, '#main-content' do
    element :caption, 'span', text: 'Safety concerns'
    element :header, 'h1', text: 'Contact between the children and the other people in this application'
    element :subheader, 'p', text: 'The court needs to know if you will allow the children to have contact with the other people in this application while you wait for a court date.'
    element :inset_text, 'div', text: 'The court will presume it\'s better for the children to have regular contact with both parents, unless there are valid reasons not to.'
    element :legend_1, 'span', text: 'Do you agree to the children spending time with the other people in this application?'
    element :label_1, 'label', text: 'Yes'
    element :label_2, 'label', text: 'Yes, but it must be supervised'
    element :label_3, 'label', text: 'No, I do not want the other person to spend time with the children'
    element :legend_2, 'span', text: 'Do you agree to the other people in this application being in touch with the children in other ways?'
    element :hint, 'div', text: 'For example, by phone, text or email'
    element :label_4, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
