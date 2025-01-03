class WithoutNoticePage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/application/without_notice'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Are you asking for a without notice hearing?'
    element :p, 'p', text: 'Hearings which take place without notice to the other people will only be justified where your case is exceptionally urgent, or there is good reason not to tell the other people about your application (either because they could take steps to obstruct the application or because doing so may expose you or the children to a risk of harm).'
    element :warning_text, 'div', text: 'Warning If you ask for a without notice hearing, the court may require you to attend on the same day as you submit your application. They will contact you to tell you when you need to go to the court.'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
