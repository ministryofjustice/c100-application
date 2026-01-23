require_relative './any_page'
module C100
  module Test
    module PageObjects
      class CookieManagementPage < AnyPage
        set_url '/about/cookies'

        section :content, '#main-content' do
          element :header, 'h1', text: 'Cookies'
          element :accept_radio_button, 'label', text: 'Yes', visible: false
          element :reject_radio_button, 'label', text: 'No', visible: false
          element :save_cookie_settings_button, 'button', text: 'Save cookie settings'
          element :notification_banner, '.govuk-notification-banner', text: "You've set your cookie preferences"
        end

        def click_save_cookie_settings
          content.save_cookie_settings_button.click
        end

      end
    end
  end
  end
