module Steps
  module Screener
    class ParentController < Steps::ScreenerStepController
      def edit
        @form_object = ParentForm.new(
          c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(ParentForm)
      end
    end
  end
end
