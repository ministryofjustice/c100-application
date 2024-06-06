module Steps
  module OtherParty
    class ChildrenCohabitOtherController < Steps::OtherPartyStepController
      def edit
        @form_object = ChildrenCohabitOtherForm.build(
          relationship_record, c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(
          ChildrenCohabitOtherForm,
          record: relationship_record,
          as: :cohabit_with_other
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
