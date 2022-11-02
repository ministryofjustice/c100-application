module Steps
  module Opening
    class ConsentOrderUploadController < Steps::OpeningStepController
      include SavepointStep
      
      before_action :store_step_path_in_session, only: [:edit, :update]

      def edit
        @form_object = ConsentOrderUploadForm.new(
          c100_application: current_c100_application,
          consent_order: current_c100_application.consent_order
        )
      end

      def update
        update_and_advance(ConsentOrderUploadForm, as: :consent_order_upload)
      end
    end
  end
end
