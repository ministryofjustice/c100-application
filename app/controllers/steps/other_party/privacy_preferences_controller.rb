module Steps
  module OtherParty
    class PrivacyPreferencesController < Steps::OtherPartyStepController
      def edit
        @form_object = PrivacyPreferencesForm.build(
          relationship_record, c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(
          PrivacyPreferencesForm,
          record: relationship_record,
          as: :privacy_preferences
        )
      end

      private

      def relationship_record
        current_c100_application.relationships.find_or_initialize_by(
          person: current_record
        )
      end
    end
  end
end
