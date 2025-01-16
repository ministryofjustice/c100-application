require_relative '../any_page'
module C100
  module Test
    module PageObjects
      module AbuseConcerns
        class DetailsPage < AnyPage
          include ActiveSupport::Testing::TimeHelpers
          set_url '/steps/abuse_concerns/details'

          section :content, '#main-content' do
            element :caption, 'span', text: 'Safety concerns'
            element :header, 'h1', text: 'About the children’s sexual abuse'
            element :span, 'span', text: 'Why do we need this information and what will we do with it?'
            element :p_1, 'p', text: 'The court needs to know if any of the other people in this application, or anyone connected to them who has contact with the children, poses a risk to the safety of the children.'
            element :p_2, 'p', text: 'If you provide information about this now, it will make it easier for the court and Cafcass to make sure your case is dealt with appropriately at the earliest opportunity. If you do not want to provide details of the abuse at this stage, you will be able to do so when you speak to Cafcass or at a later stage in the court proceedings.'
            element :p_3, 'p', text: 'The Children and Family Court Advisory and Support Service (Cafcass), in England, and Cafcass Cymru, in Wales, protect and promote the interests of children involved in family court cases. An advisor from Cafcass or Cafcass Cymru will look at your answers as part of their safeguarding checks, and may need to ask you further questions.'
            element :link_1, 'a', text: 'Children and Family Court Advisory and Support Service (Cafcass)'
            element :link_2, 'a', text: 'Cafcass Cymru'
            element :p_4, 'p', text: 'As part of their enquiries they will contact organisations such as the police and local authorities for any relevant information about you, any other person and the children.'
            element :p_5, 'p', text: 'They will submit information to the court before your first hearing. Their assessment helps the judge make a decision that is in the best interests of the children.'
            element :p_6, 'p', text: 'The information you provide in this section will also be shared with the respondents so that they have the opportunity to respond to your allegations.'
            element :label_1, 'label', text: 'Briefly describe what happened and who was involved, if you feel able to'
            element :hint_1, 'div', text: 'This information will be treated sensitively and you’ll have the opportunity to give further details later in the court proceedings if you wish'
            element :label_2, 'label', text: 'When did this behaviour start?'
            element :hint_2, 'div', text: 'Add an approximate date if you’re unsure'
            element :legend_1, 'span', text: 'Is the behaviour still ongoing?'
            element :yes, 'label', text: 'Yes'
            element :no, 'label', text: 'No'
            element :legend_2, 'span', text: 'Have you ever asked for help?'
            element :hint_3, 'div', text: 'For example, your GP'
            element :subheader_1, 'h2', text: 'Report an incident'
            element :p_7, 'p', text: 'Always call 999 if there’s an emergency or if you think a child’s in danger.'
            element :p_8, 'p', text: 'If it is not an emergency, you can:'
            element :link_3, 'a', text: 'report child abuse'
            element :link_4, 'a', text: 'report domestic abuse'
            element :subheader_2, 'h2', text: 'Get support'
            element :subheader_3, 'h3', text: 'Child safety'
            element :link_5, 'a', text: 'NSPCC'
            element :link_6, 'a', text: 'Childline'
            element :subheader_4, 'h3', text: 'Domestic abuse'
            element :link_7, 'a', text: 'National Domestic Violence Helpline'
            element :link_8, 'a', text: 'Women’s Aid'
            element :link_9, 'a', text: 'Men’s Advice Line'

            element :continue_button, 'button', text: 'Continue'
          end
        end
      end
    end
  end
end
