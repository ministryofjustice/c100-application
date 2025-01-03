class ParentalResponsibilityPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/children/parental_responsibility/'

  section :content, '#main-content' do
    element :header, 'h1', text: /Parental responsibility for .*?/
    element :label, 'label', text: 'State everyone who has parental responsibility for and how they have parental responsibility.'
    element :hint, 'p', text: 'For example \'child\'s mother\', or \'child\'s father who was married to the mother when the child was born.\''
    element :link, 'a', text: 'See section E of leaflet CB1 for more information'

    element :continue_button, 'button', text: 'Continue'
  end
end
