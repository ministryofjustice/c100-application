module Steps
  module MiamExemptions
    class MiscController < Steps::MiamExemptionsStepController
      def edit
        @form_object = MiscForm.build(
          c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(MiscForm, as: :misc)
      end

      private

      def additional_permitted_params
        [misc: [], exemptions_collection: []]
      end
    end
  end
end
