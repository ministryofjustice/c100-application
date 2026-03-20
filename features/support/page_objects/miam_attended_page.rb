class MiamAttendedPage < YesNoPage
  set_url '/steps/miam/attended'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Have you attended a Mediation Information and Assessment Meeting (MIAM)?'
  end
end