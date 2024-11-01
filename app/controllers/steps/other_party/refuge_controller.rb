module Steps
  module OtherParty
    class RefugeController < Steps::OtherPartyStepController
      def edit
        @form_object = RefugeForm.build(
          relationship_record,
          c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(
          RefugeForm,
          record: relationship_record,
          as: :refuge
        )
      end

      def relationship_record
        current_c100_application.relationships.find_or_initialize_by(
          person: current_record
        )
      end
    end
  end
end
