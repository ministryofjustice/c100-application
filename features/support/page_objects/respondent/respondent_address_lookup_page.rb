class RespondentAddressLookupPage < BasePage
  set_url_matcher %r{/steps/address/lookup/.*}

  section :content, '#main-content' do
    element :header, 'h1', text: 'Address of'
    element :postcode_field, "input[name='steps_address_lookup_form[postcode]']"
    element :outside_uk_link, "a", text: "I don’t know their postcode or they live outside the UK"
  end

  def submit_postcode(postcode)
    content.postcode_field.set postcode
    click_continue_button
  end

  def click_outside_uk
    content.outside_uk_link.click
  end

  def continue_without_postcode
    click_continue_button
  end
end
