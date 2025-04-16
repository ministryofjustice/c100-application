class PdfGenerationJob < ApplicationJob
  queue_as :default

  def perform(application_id:, type:)
    Rails.logger.info "PdfGenerationJob started for #{application_id} / #{type}"

    application = C100Application.find(application_id).reload
    presenter = Summary::PdfPresenter.new(application)
    presenter.generate

    pdf_data = presenter.to_pdf
    key = "C100_Application_#{application_id}_#{type}"
    Rails.logger.info "Writing cache key: C100_Application_#{application_id}_#{type}"
    Rails.cache.write(key, pdf_data, expires_in: 15.minutes)
  end
end
