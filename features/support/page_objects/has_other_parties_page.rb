class HasOtherPartiesPage < YesNoPage
  set_url '/steps/respondent/has_other_parties'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Is there anyone else who should know about your application?'
  end
end