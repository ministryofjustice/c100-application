class ExistingCourtOrderPage < YesNoPage
  set_url '/steps/application/existing_court_order'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Is there an order under section 91(14) Children Act 1989, a limited civil restraint order, a general civil restraint order or an extended civil restraint order in force which means you need permission to make this application?'
  end
end