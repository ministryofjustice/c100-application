class WithoutNoticePage < YesNoPage
  set_url '/steps/application/without_notice'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Are you asking for a without notice hearing?'
  end
end