module Steps
  module Application
    class CourtOrderUploadsController < Steps::ApplicationStepController
      include SavepointStep

      before_action :store_step_path_in_session, only: [:edit, :update]
      before_action :set_documents_list, only: [:edit, :update]

      def edit
        @form_object = CourtOrderUploadsForm.new(
          c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(CourtOrderUploadsForm, as: :court_order_uploads)
      end

      private

      def set_documents_list
        @documents_list = current_c100_application&.documents(:court_order_uploads) || []
      end
    end
  end
end
