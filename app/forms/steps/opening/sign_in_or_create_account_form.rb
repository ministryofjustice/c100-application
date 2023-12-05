module Steps
  module Opening
    class SignInOrCreateAccountForm < BaseForm
      include SingleQuestionForm

      attribute :has_myhmcts_account, YesNo

      yes_no_attribute :has_myhmcts_account
    end
  end
end
