module CompletionStep
  extend ActiveSupport::Concern

  included do
    before_action :check_application_is_completed
    before_action :generate_pdf
  end

  def show
    @court = current_c100_application.court
    @c100_application = current_c100_application
  end

  private

  def check_application_is_completed
    return if current_c100_application.completed?

    redirect_to steps_opening_warning_path, allow_other_host: true
  end

  def generate_pdf
    PdfGenerationJob.perform_later(application_id: current_c100_application.id, type: 'completed')
  end
end
