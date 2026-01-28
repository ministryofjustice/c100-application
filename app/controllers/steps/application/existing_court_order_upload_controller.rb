module Steps
  module Application
    class ExistingCourtOrderUploadController < Steps::ApplicationStepController
      def edit
        @form_object = ExistingCourtOrderUploadForm.new(
          c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(ExistingCourtOrderUploadForm, as: :existing_court_order_upload)
      end
    end
  end
end
