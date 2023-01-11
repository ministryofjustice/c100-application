module Steps
  module Miam
    class CertificationUploadController < Steps::MiamStepController
      include SavepointStep

      before_action :store_step_path_in_session, only: [:edit, :update]

      def edit
        @form_object = CertificationUploadForm.new(
          c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(CertificationUploadForm, as: :certification_upload)
      end
    end
  end
end
