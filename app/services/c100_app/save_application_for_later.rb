module C100App
  class SaveApplicationForLater
    attr_reader :c100_application, :user

    def initialize(c100_application, user)
      @c100_application = c100_application
      @user = user
      @email_sent = false
    end

    def save
      if c100_application&.navigation_stack && PrlChange.changes_apply?
        return false unless c100_application.navigation_stack.include? "/steps/opening/consent_order"
      end

      c100_application.nil? || c100_application.user.present? || claim_ownership!
    end

    def email_sent?
      @email_sent
    end

    private

    def claim_ownership!
      c100_application.update(user:) && send_confirmation_email
    end

    def send_confirmation_email
      NotifyMailer.application_saved_confirmation(c100_application).deliver_later
      @email_sent = true
    end
  end
end
