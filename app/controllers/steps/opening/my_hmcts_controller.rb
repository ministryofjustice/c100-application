module Steps
  module Opening
    class MyHmctsController < Steps::OpeningStepController
      include SavepointStep

      def edit
        @form_object = MyHmctsForm.new(
          c100_application: current_c100_application,
          is_solicitor: current_c100_application.is_solicitor,
          use_my_hmcts: current_c100_application.use_my_hmcts
        )
      end

      def update
        update_and_advance(MyHmctsForm, as: :my_hmcts)
      end
    end
  end
end
