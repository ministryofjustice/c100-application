module Steps
  module Application
    class ExistingCourtOrderUploadController < Steps::ApplicationStepController

      before_action :store_step_path_in_session, only: [:edit, :update]

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
