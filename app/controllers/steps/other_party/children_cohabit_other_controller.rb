module Steps
  module OtherParty
    class ChildrenCohabitOtherController < Steps::OtherPartyStepController
      def edit
        @form_object = ChildrenCohabitOtherForm.build(
          current_record, c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(
          ChildrenCohabitOtherForm,
          record: current_record,
          as: :cohabit_with_other
        )
      end
    end
  end
end
