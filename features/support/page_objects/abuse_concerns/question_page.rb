class QuestionPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/abuse_concerns/question'

  section :content, '#main-content' do
    element :caption, 'span', text: 'Safety concerns'
    element :header, 'h1', text: 'Have the children ever been sexually abused by the respondent?'
    element :p_1, 'p', text: 'A child is sexually abused when they are forced or persuaded to take part in sexual activities, including online. It may not necessarily involve a high level of violence, and the child may or may not be aware of what\'s happening.'
    element :p_2, 'p', text: 'There are 2 types of child sexual abuse:'
    element :li_1, 'li', text: 'contact abuse (where an abuser makes physical contact)'
    element :li_2, 'li', text: 'non-contact abuse (for example grooming or exploitation)'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
