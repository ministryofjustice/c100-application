module Steps
  module Completion
    class SummaryController < Steps::CompletionStepController
      skip_before_action :check_application_not_completed, only: [:show, :check_pdf_status]

      def show
        respond_to do |format|
          format.pdf do
            type = params[:type]
            key = "C100_Application_#{current_c100_application.id}_#{type}"
            pdf_data = Rails.cache.read(key)

            if pdf_data
              # Will render the template defined in `BasePdfForm#template`
              # i.e. `steps/completion/summary/show.pdf.erb`
              send_data(pdf_data, filename: "C100 child arrangements application.pdf")
            end
          end
        end
      end

      def check_pdf_status
        expires_now
        type = params[:type]
        key = "C100_Application_#{current_c100_application.id}_#{type}"
        pdf_data = Rails.cache.read(key)

        if pdf_data
          render json: { job_completed: true }
        else
          render json: { job_completed: false }
        end
      end
    end
  end
end
