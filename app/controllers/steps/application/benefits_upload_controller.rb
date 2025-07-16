module Steps
  module Application
    class BenefitsUploadController < Steps::ApplicationStepController
      include DocumentUploadHelper

      before_action :store_step_path_in_session, only: [:edit, :update]

      def edit
        @form_object = BenefitsUploadForm.new(
          c100_application: current_c100_application
        )
      end

      def update
        if request.xhr?
          update_and_advance(BenefitsUploadForm, as: :benefits_upload) do
            render(
              partial: 'steps/shared/document_upload/current_documents',
              locals: {
                current_documents: uploaded_documents(:benefits_evidence),
                document_key: :benefits_evidence
              },
              layout: false
            )
          end
        else
          update_and_advance(BenefitsUploadForm, as: :benefits_upload)
        end
      end



      def document_key
        :benefits_evidence
      end
    end
  end
end
