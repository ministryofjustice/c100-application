class WithoutNoticeDetailsPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/application/without_notice_details'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Details of without notice hearing'
    element :label_1, 'label', text: 'Give details of why you’re asking for a without notice hearing'
    element :hint_1, 'div', text: 'A judge will need to be sure that there is a good reason why the other people in the application should not be told about the application before the hearing takes place.'
    element :legend_1, 'span', text: 'Are you asking for a without notice hearing because the other person or people may do something that would obstruct the order you are asking for if they knew about the application?'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    element :legend_2, 'span', text: 'Are you asking for a without notice hearing because there is literally no time to give notice of the application to the other person or people?'
    element :hint_2, 'div', text: 'This may be relevant in cases of exceptional urgency where the order is needed to prevent a threatened wrongful act. In some cases you may still be expected to have tried to give informal notice for example by telephone, text message, or email.'

    element :continue_button, 'button', text: 'Continue'
  end
end
