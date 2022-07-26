module Steps
  module Children
    class ParentalResponsibilityController < Steps::ChildrenStepController
      def edit
        @form_object = ParentalResponsibilityForm.build(
          current_record, c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(
          ParentalResponsibilityForm,
          record: current_record,
          as: :parental_responsibility
        )
      end
    end
  end
end
