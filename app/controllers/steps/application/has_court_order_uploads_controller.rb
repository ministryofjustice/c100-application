module Steps
  module Application
    class HasCourtOrderUploadsController < Steps::ApplicationStepController
      include SavepointStep

      before_action :store_step_path_in_session, only: [:edit, :update]

      def edit
        @form_object = HasCourtOrderUploadsForm.new(
          c100_application: current_c100_application,
          has_court_order_uploads: current_c100_application.has_court_order_uploads
        )
      end

      def update
        update_and_advance(HasCourtOrderUploadsForm, as: :has_court_order_uploads)
      end

    end
  end
end
