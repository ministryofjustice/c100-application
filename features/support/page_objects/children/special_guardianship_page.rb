class SpecialGuardianshipPage < YesNoPage
  set_url_matcher %r{/steps/children/special_guardianship_order/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'Is there a Special Guardianship Order in force in relation to'
  end
end