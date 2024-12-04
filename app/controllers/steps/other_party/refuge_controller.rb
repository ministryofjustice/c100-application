module Steps
  module OtherParty
    class RefugeController < Steps::OtherPartyStepController
      def edit
        @form_object = RefugeForm.build(
          current_record,
          c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(
          RefugeForm,
          record: current_record,
          as: :refuge
        )
      end
    end
  end
end
