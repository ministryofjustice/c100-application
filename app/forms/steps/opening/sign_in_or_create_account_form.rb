module Steps
  module Opening
    class SignInOrCreateAccountForm < BaseForm
      include SingleQuestionForm

      attribute :has_myhmcts_account, :yes_no

      yes_no_attribute :has_myhmcts_account
    end
  end
end
