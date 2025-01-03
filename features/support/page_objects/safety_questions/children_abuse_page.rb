class ChildrenAbusePage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/safety_questions/children_abuse'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have the children suffered or are they at risk of suffering domestic or child abuse?'
    element :legend, 'span', text: 'Safety concerns'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    element :inset_text, 'div', text: 'Only include abuse by the people in this application or someone connected to them who has contact with the children.'
    element :details, 'p', text: 'This includes any action that causes harm to a child. Harm includes seeing or hearing the ill-treatment of others.'
    element :examples_header, 'p', text: 'Examples include:'
    element :li_1, 'li', text: 'emotional or psychological abuse'
    element :li_2, 'li', text: 'physical abuse'
    element :li_3, 'li', text: 'sexual abuse'
    element :li_4, 'li', text: 'witnessing domestic violence or abuse'
    element :link, 'a', text: 'Find out about the signs of child abuse'
    element :summary, 'span', text: 'Why do we need this information and what will we do with it?'
    element :summary_details, 'p', text: 'The court needs to know if any of the other people in this application, or anyone connected to them who has contact with the children, poses a risk to the safety of the children.'
    element :summary_details_2, 'p', text: 'If you provide information about this now, it will make it easier for the court and Cafcass to make sure your case is dealt with appropriately at the earliest opportunity. If you do not want to provide details of the abuse at this stage, you will be able to do so when you speak to Cafcass or at a later stage in the court proceedings.'
    element :summary_details_3, 'p', text: 'The Children and Family Court Advisory and Support Service (Cafcass), in England, and Cafcass Cymru, in Wales, protect and promote the interests of children involved in family court cases. An advisor from Cafcass or Cafcass Cymru will look at your answers as part of their safeguarding checks, and may need to ask you further questions.'
    element :cafcass_link, 'a', text: 'Children and Family Court Advisory and Support Service (Cafcass)'
    element :cafcass_link_2, 'a', text: 'Cafcass Cymru'
    element :summary_details_4, 'p', text: 'As part of their enquiries they will contact organisations such as the police and local authorities for any relevant information about you, any other person and the children.'
    element :summary_details_5, 'p', text: 'They will submit information to the court before your first hearing. Their assessment helps the judge make a decision that is in the best interests of the children.'
    element :summary_details_6, 'p', text: 'The information you provide in this section will also be shared with the respondents so that they have the opportunity to respond to your allegations.'

    element :continue_button, 'button', text: 'Continue'
  end
end
