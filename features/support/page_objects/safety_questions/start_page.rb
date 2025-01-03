class StartPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/safety_questions/start'

  section :content, '#content' do
    element :header, 'h1', text: 'Safety concerns'
    element :intro_paragraph, 'p', text: 'The court needs to know if anyone who spends time with the children poses a risk to their safety or yours.'
    element :inset_text, 'div.govuk-inset-text', text: 'We use ‘children’ as a general term to avoid repetition. In this service it applies to whether it is about a child or children.'
    element :harm_paragraph_1, 'p', text: 'The following questions will ask whether you or the children have experienced, or are at risk of experiencing, any form of harm.'
    element :harm_paragraph_2, 'p', text: 'Harm to a child means ill treatment or damage to health and development, including, for example, damage suffered from seeing or hearing the ill treatment of another.'
    element :child_abuse_link, 'a', text: 'signs of child abuse'
    element :domestic_abuse_link, 'a', text: 'domestic abuse'
    element :cafcass_link_1, 'a', text: 'Children and Family Court Advisory and Support Service (Cafcass)'
    element :cafcass_link_2, 'a', text: 'Cafcass Cymru'
    element :why_info_header, 'h2', text: 'Why do we need this information and what will we do with it?'
    element :why_info_paragraph_1, 'p', text: 'The court needs to know if any of the other people in this application, or anyone connected to them who has contact with the children, poses a risk to the safety of the children.'
    element :why_info_paragraph_2, 'p', text: 'If you provide information about this now, it will make it easier for the court and Cafcass to make sure your case is dealt with appropriately at the earliest opportunity.'
    element :why_info_paragraph_3, 'p', text: 'If you do not want to provide details of the abuse at this stage, you will be able to do so when you speak to Cafcass or at a later stage in the court proceedings.'
    element :why_info_paragraph_4, 'p', text: 'The Children and Family Court Advisory and Support Service (Cafcass), in England, and Cafcass Cymru, in Wales, protect and promote the interests of children involved in family court cases.'

    element :why_info_paragraph_5, 'p', text: 'An advisor from Cafcass or Cafcass Cymru will look at your answers as part of their safeguarding checks, and may need to ask you further questions.'
    element :why_info_paragraph_6, 'p', text: 'As part of their enquiries they will contact organisations such as the police and local authorities for any relevant information about you, any other person and the children.'
    element :why_info_paragraph_7, 'p', text: 'They will submit information to the court before your first hearing. Their assessment helps the judge make a decision that is in the best interests of the children.'
    element :why_info_paragraph_8, 'p', text: 'The information you provide in this section will also be shared with the respondents so that they have the opportunity to respond to your allegations.'


    element :continue_button, 'button', text: 'Continue'
  end
end
