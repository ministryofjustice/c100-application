class SpecialArrangementsPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/attending_court/special_arrangements'

  section :content, '#main-content' do
    element :caption, 'span', text: 'Attending court'
    element :header, 'h1', text: 'Do you or the children need specific safety arrangements at court?'
    element :subheader, 'p', text: 'Not every court has the facilities listed here, and some need to be agreed by a judge, for example the use of protective screens.'
    element :p_1, 'p', text: 'Domestic Abuse Act 2021'
    element :p_2, 'p', text: 'Provisions in the Domestic Abuse Act 2021 have the effect of preventing an individual accused of abuse from questioning in person a party or witness in the case who is the victim of the abuse, and also prevents a victim of abuse from questioning in person the accused individual in specified circumstances.'
    element :p_3, 'p', text: 'If the court directs that the proceedings be listed for a hearing where oral evidence may be given, form EX740 (person making the abuse accusation) or form EX741 (person accused of abuse) ‘Application and information needed by the court to consider whether to prevent (prohibit) questioning (cross-examination) in person’ may need to be completed so that the court can consider whether questioning in person should be prevented. The court will send the appropriate form with the court order.'
    element :p_4, 'p', text: 'The court will contact you to discuss safety arrangements before your hearing.'
    element :hint, 'div', text: 'One of the people named in this application needs:'
    element :label_1, 'label', text: 'Separate waiting rooms'
    element :label_2, 'label', text: 'Separate exits and entrances'
    element :label_3, 'label', text: 'Protective screens - this needs to be approved by a judge'
    element :label_4, 'label', text: 'Video links - this needs to be approved by a judge'
    element :label_5, 'label', text: 'You can add more detail if necessary'

    element :continue_button, 'button', text: 'Continue'
  end
end
