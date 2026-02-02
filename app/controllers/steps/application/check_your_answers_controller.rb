module Steps
  module Application
    class CheckYourAnswersController < Steps::ApplicationStepController
      include RemoveExemptionHelper
      include RemoveExistingCourtOrderHelper

      before_action :set_presenter
      before_action :check_remove_files

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

      def check_remove_files
        remove_file_if_no_evidence(current_c100_application)
        remove_file_if_no_uploadable(current_c100_application)
      end
    end
  end
end
