class UrgencyPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/miam_exemptions/urgency'

  section :content, '#main-content' do
    element :caption, 'span', text: 'MIAM exemptions'
    element :header, 'h1', text: 'Confirming why your application is urgent'
    element :legend, 'span', text: 'Do you confirm any of the following urgency reasons?'
    element :hint, 'div', text: 'Select all that apply or ‘None of these’'
    element :label_1, 'label', text: 'There is risk to the life, liberty or physical safety of you, your family or your home.'
    element :label_2, 'label', text: 'Any delay caused by attending a MIAM would cause significant financial hardship to the prospective applicant.'
    element :label_3, 'label', text: 'Any delay caused by attending a MIAM would cause a risk of harm to the children.'
    element :label_4, 'label', text: 'Any delay caused by attending a MIAM would cause a risk of unlawful removal of a child from the UK, or a risk of unlawful retention of a child who is currently outside England and Wales.'
    element :label_5, 'label', text: 'Any delay caused by attending a MIAM would cause a significant risk of a miscarriage of justice.'
    element :label_6, 'label', text: 'Any delay caused by attending a MIAM would cause irretrievable problems in dealing with the dispute (including the irretrievable loss of significant evidence).'
    element :label_7, 'label', text: 'There is a significant risk that in the period necessary to schedule and attend a MIAM, proceedings relating to the dispute will be brought in another state in which a valid claim to jurisdiction may exist, such that a court in that other State would be seized of the dispute before a court in England and Wales.'
    element :radio_divider, 'div', text: 'or'
    element :label_8, 'label', text: 'None of these'

    element :continue_button, 'button', text: 'Continue'
  end
end
