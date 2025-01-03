class MiscPage < AnyPage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/steps/iam_exemptions/misc'

  section :content, '#main-content' do
    element :caption, 'span', text: 'MIAM exemptions'
    element :header, 'h1', text: 'Confirming other valid reasons for not attending'
    element :legend, 'span', text: 'Do you have any other valid reasons for not attending a MIAM?'
    element :hint_1, 'div', text: 'Select all that apply or ‘None of these’'
    element :label_1, 'label', text: 'You’re applying for a without notice hearing.'
    element :hint_2, 'div', text: 'Hearings which take place without notice to the other people will only be justified where your case is exceptionally urgent or there is good reason not to tell the other people about your application (either because they could take steps to obstruct the application or because doing so may expose you or the children to a risk of harm).'
    element :label_2, 'label', text: 'You or the prospective respondents are under 18 years old.'
    element :label_3, 'label', text: '(i) The prospective applicant is not able to attend a MIAM online or by video-link and an explanation of why this is the case is provided to the court using the text box provided; and'
    element :label_4, 'label', text: '(ii) the prospective applicant has contacted as many authorised family mediators as have an office within fifteen miles of his or her home (or five of them if there are five or more), and all of them have stated that they are not available to conduct a MIAM within fifteen business days of the date of contact; and'
    element :label_5, 'label', text: '(iii) the names, postal addresses and telephone numbers or e-mail addresses for such authorised family mediators, and the dates of contact, are provided to the court using the text box provided'
    element :label_6, 'label', text: '(i) The prospective applicant is not able to attend a MIAM online or by video-link and an explanation of why this is the case is provided to the court using the text box provided; and'
    element :label_7, 'label', text: '(ii) the prospective applicant is subject to a disability or other inability that would prevent attendance in person at a MIAM unless appropriate facilities can be offered by an authorised mediator; and'
    element :label_8, 'label', text: '(iii) the prospective applicant has contacted as many authorised family mediators as have an office within fifteen miles of his or her home (or five of them if there are five or more), and all have stated that they are unable to provide such facilities; and'
    element :label_9, 'label', text: '(iv) the names, postal addresses and telephone numbers or e-mail addresses for the authorised family mediators contacted by the prospective applicant, and the dates of contact, are provided to the court using the text box provided'
    element :label_10, 'label', text: '(i) The prospective applicant is not able to attend a MIAM online or by video-link; and'
    element :label_11, 'label', text: '(ii) there is no authorised family mediator with an office within fifteen miles of the prospective applicant’s home; and'
    element :label_12, 'label', text: '(iii) an explanation of why this exemption applies is provided by the prospective applicant to the court using the text box provided'
    element :label_13, 'label', text: 'The prospective applicant cannot attend a MIAM because the prospective applicant is'
    element :label_14, 'label', text: '(i) in prison or any other institution in which the prospective applicant is required to be detained and facilities cannot be made available for them to attend a MIAM online or by video link; or'
    element :label_15, 'label', text: '(ii) subject to conditions of bail that prevent contact with the other person; or'
    element :label_16, 'label', text: '(iii) subject to a licence with a prohibited contact requirement in relation to the other person'
    element :radio_divider, 'div', text: 'or'
    element :label_17, 'label', text: 'None of these'
    element :hint_3, 'p', text: 'Where evidence is needed to support an exemption, you will need to submit a copy of this document with this application to court.'

    element :continue_button, 'button', text: 'Continue'
  end
end
