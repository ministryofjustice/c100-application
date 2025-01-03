class RefugePage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/other_party/refuge'

  section :content, '#main-content' do
    element :header, 'h1', text: /Is .*?'s currently resident in a refuge?/
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
