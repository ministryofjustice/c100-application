module Steps
  module OtherParty
    class IdentityPreferencesController < Steps::OtherPartyStepController
      def edit
        @form_object = IdentityPreferencesForm.build(
          current_record, c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(
          IdentityPreferencesForm,
          record: current_record,
          as: :identity_preferences
        )
      end
    end
  end
end
