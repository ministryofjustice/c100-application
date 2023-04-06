module Steps
  module Opening
    class SignInOrCreateAccountController < Steps::OpeningStepController

      def edit
        @form_object = SignInOrCreateAccountForm.build(current_c100_application)
      end

      def update
        update_and_advance(SignInOrCreateAccountForm, as: :sign_in_or_create_account)
      end
    end
  end
end
