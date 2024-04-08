module Steps
  module MiamExemptions
    class ExemptionUploadController < Steps::MiamExemptionsStepController
      include SavepointStep

      before_action :store_step_path_in_session, only: [:edit, :update]

      def edit
        @form_object = ExemptionUploadForm.new(
          c100_application: current_c100_application
        )
      end

      def update
        update_and_advance(ExemptionUploadForm, as: :exemption_upload)
      end
    end
  end
end
