class BasePage < SitePrism::Page
  # section :content, '#content' do
  #   element :complete_processing_button, 'input[value="Complete processing"]', visible: false
  #   element :select_from_list_error, '.error', text: 'Select a reason or reasons why you are rejecting the evidence'
  #   element :saved_alert, '.govuk-error-summary', text: 'Your changes have been saved.'
  #   element :back_to_start_link, 'a.govuk-button', text: 'Back to start'
  #   element :back_to_list_link, 'a.govuk-button', text: 'Back to list'
  # end
  include ActiveSupport::Testing::TimeHelpers

  def has_google_analytics_enabled?
    wait_until_true(timeout: 100) do
      !google_analytics_enabled
    end
  end

  section :footer, '.govuk-footer' do
    element :header, 'h2', text: 'Support links'
  end

  section :notification_banner, '.govuk-notification-banner' do
    element :banner_title, '.govuk-notification-banner__header.govuk-notification-banner__title'
    element :banner_content, '.govuk-notification-banner__content .govuk-notification-banner__heading'
  end

  section :cookie_banner, '.govuk-cookie-banner' do
    element :accept_button, :button, 'Accept analytics cookies'
    element :reject_button, :button, 'Reject analytics cookies'
    element :link_to_cookie_page, :link, 'View cookies'

    def view_cookies
      link_to_cookie_page.click
    end

    def accept
      accept_button.click
    end

    def reject
      reject_button.click
    end

  end

  section :cookie_confirmation_banner, '.govuk-cookie-banner.confirmation' do
    element :hide_message_button, :button, 'Hide this message'
    element :change_cookie_settings_link, :link, 'change your cookie settings'
    def has_message?(*args)
      message_container.has_message?(*args)
    end

    def hide_message
      hide_message_button.click
    end

    def change_cookie_settings
      change_cookie_settings_link.click
    end

    private

    section :message_container, '.govuk-cookie-banner__message' do
      element :message, '.govuk-cookie-banner__content'
    end
  end

  private

  def google_analytics_enabled
    page.evaluate_script("window['ga-disable-#{Rails.application.config.x.analytics_tracking_id}']")
  end

  def wait_until_true(timeout: Capybara.default_max_wait_time, sleep: 0.1)
    Timeout.timeout(timeout) do
      loop do
        break true if yield
        sleep sleep
      end
    end
  end
end
