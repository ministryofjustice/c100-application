module FeesHelper
  def fee_amount
    ActionController::Base.helpers.number_to_currency(
      Rails.configuration.x.court_fee.amount_in_pence / 100
    )
  end

  def phase_banner_copy
    page = @c100_application.try(:navigation_stack).try(:last)
    if page == "/steps/completion/what_next"
      t('.feedback_completed_html')
    else
      t('.feedback_processing_html')
    end
  end
end
