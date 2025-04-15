module Steps
  module Application
    class CheckYourAnswersController < Steps::ApplicationStepController
      include RemoveExemptionHelper

      before_action :set_presenter
      before_action :check_exemption_file
      before_action :generate_pdf

      def edit
        @form_object = DeclarationForm.build(current_c100_application)
      end

      def update
        update_and_advance(DeclarationForm, as: :declaration)
      end

      def resume; end

      private

      def set_presenter
        @presenter = Summary::HtmlPresenter.new(current_c100_application)
      end

      def check_exemption_file
        remove_file_if_no_evidence(current_c100_application)
      end

      def generate_pdf
        PdfGenerationJob.perform_later(application_id: current_c100_application.id, type: 'draft')
      end
    end
  end
end
