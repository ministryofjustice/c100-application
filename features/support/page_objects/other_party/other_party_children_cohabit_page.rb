class OtherPartyChildrenCohabitPage < YesNoPage
  set_url_matcher %r{/steps/other_party/children_cohabit_other/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'Do any of the children live with'
  end
end
