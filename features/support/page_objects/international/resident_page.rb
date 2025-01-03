class ResidentPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/international/resident'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Is the life of the child or children, a parent, or anyone significant to the children mainly based in a country outside England or Wales?'
    element :subheader, 'p', text: 'Including for example, a grandparent or any other close relative. This may include them working, owning property, having children in school or their main family life taking place outside England or Wales.'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'

    element :continue_button, 'button', text: 'Continue'
  end
end
