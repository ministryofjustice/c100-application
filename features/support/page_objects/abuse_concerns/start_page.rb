class StartPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/abuse_concerns/start'

  section :content, '#main-content' do
    element :caption, 'span', text: 'Safety concerns'
    element :header, 'h1', text: 'You and the children'
    element :p_1, 'p', text: 'You told us:'
    element :p_2, 'p', text: 'We’ll need to ask you some further questions about your concerns.'
    element :p_3, 'p', text: 'Your answers will help the court consider any risks to you or the children. This information forms part of your court application and will be dealt with sensitively.'
    element :p_4, 'p', text: 'You may find some of the following questions difficult or upsetting to answer. Please complete them as best you can.'

    element :continue_button, 'button', text: 'Continue'
    element :span, 'span', text: 'Why do we need this information and what will we do with it?'
    element :p_1, 'p', text: 'The court needs to know if any of the other people in this application, or anyone connected to them who has contact with the children, poses a risk to the safety of the children.'
    element :p_2, 'p', text: 'If you provide information about this now, it will make it easier for the court and Cafcass to make sure your case is dealt with appropriately at the earliest opportunity. If you do not want to provide details of the abuse at this stage, you will be able to do so when you speak to Cafcass or at a later stage in the court proceedings.'
    element :p_3, 'p', text: 'The Children and Family Court Advisory and Support Service (Cafcass), in England, and Cafcass Cymru, in Wales, protect and promote the interests of children involved in family court cases. An advisor from Cafcass or Cafcass Cymru will look at your answers as part of their safeguarding checks, and may need to ask you further questions.'
    element :link_1, 'a', text: 'Children and Family Court Advisory and Support Service (Cafcass)'
    element :link_2, 'a', text: 'Cafcass Cymru'
    element :p_4, 'p', text: 'As part of their enquiries they will contact organisations such as the police and local authorities for any relevant information about you, any other person and the children.'
    element :p_5, 'p', text: 'They will submit information to the court before your first hearing. Their assessment helps the judge make a decision that is in the best interests of the children.'
    element :p_6, 'p', text: 'The information you provide in this section will also be shared with the respondents so that they have the opportunity to respond to your allegations.'
  end
end
