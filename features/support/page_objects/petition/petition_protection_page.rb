class PetitionProtectionPage < BasePage
  set_url '/steps/petition/protection'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Is there anything else you are asking the court to decide, specifically to protect the safety of you or the children?'
    element :protection_order_no, 'input[name="steps_petition_protection_form[protection_orders]"][value="no"]'
    element :protection_order_yes, 'input[name="steps_petition_protection_form[protection_orders]"][value="yes"]', visible: false
    element :protection_orders_details, 'textarea[name="steps_petition_protection_form[protection_orders_details]"]', visible: false
    element :continue_button, "button", text: "Continue"
  end

  def submit_no
    content.protection_order_no.click
    content.continue_button.click
  end

  def submit_yes(details:)
    content.protection_order_yes.click
    content.protection_orders_details.set(details)
    content.continue_button.click
  end
end