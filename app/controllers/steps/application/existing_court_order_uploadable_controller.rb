module Steps
  module Application
    class ExistingCourtOrderUploadableController < Steps::ApplicationStepController
      def edit
        @form_object = ExistingCourtOrderUploadableForm.new(
          c100_application: current_c100_application,
          existing_court_order_uploadable: current_c100_application.existing_court_order_uploadable,
        )
      end

      def update
        update_and_advance(ExistingCourtOrderUploadableForm)
      end
    end
  end
end
