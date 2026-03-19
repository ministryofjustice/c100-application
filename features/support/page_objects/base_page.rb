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

  class CYASummaryListRow < SitePrism::Section
    element :key, 'dt.govuk-summary-list__key'
    element :value, 'dd.govuk-summary-list__value'
    element :change, 'dd.govuk-summary-list__actions a'

    def question
      key.text
    end

    def answer
      value.text
    end

    def yes?
      answer == 'Yes'
    end

    def no?
      answer == 'No'
    end

    def not_applicable?
      answer == '[Not applicable in this case]' 
    end

    def dont_know?
      answer == 'Don\'t know' 
    end

    def not_needed?
      answer == 'Not needed'
    end

    def none_selected?
      answer == 'None selected'
    end

    def yes_voicemail?
      answer == 'Yes, the court can leave a voicemail'
    end
  end

  class CYAPersonalDetails < SitePrism::Section
    section :person_previous_name, CYASummaryListRow, '#person_previous_name'
    section :date_of_birth, CYASummaryListRow, '#person_dob'
    section :person_sex, CYASummaryListRow, '#person_sex'
    section :person_birthplace, CYASummaryListRow, '#person_birthplace'

    def previous_name
      person_previous_name.answer
    end

    def birthplace
      person_birthplace.answer
    end

    def dob
      date_of_birth.answer
    end

    def sex
      person_sex.answer
    end
  end

  class CYAGroup < SitePrism::Section
    def self.row(name, klass = CYASummaryListRow, id)
      section name, klass, id
    end
    
    def self.rows(name, klass = CYASummaryListRow, id)
      sections name, klass, id
    end
  end

  class CYANestedSummaryRow < CYASummaryListRow
    element :value, 'dd.govuk-summary-list__value:not(:has(dl))'
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
