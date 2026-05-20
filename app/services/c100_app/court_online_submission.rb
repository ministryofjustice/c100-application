module C100App
  class CourtOnlineSubmission < BaseOnlineSubmission
    def process
      generate_documents && deliver_email && audit_data
    end

    def to_address
      c100_application.court.documents_email
    end

    private

    def generate_documents
      documents.store(:bundle, generate_pdf(:c100, :c1a))
      documents.store(:applicant_c8_forms, generate_grouped_c8_pdf(:applicant))
      documents.store(:respondent_c8_forms, generate_grouped_c8_pdf(:respondent))
      documents.store(:other_party_c8_forms, generate_grouped_c8_pdf(:other_party))

      # Temporary removal
      # documents.store(:json_form, generate_json)
    end

    def generate_grouped_c8_pdf(type)
      presenter = Summary::PdfPresenter.new(c100_application)

      rendered =
        case type
        when :applicant
          presenter.generate_applicant_c8s
        when :respondent
          presenter.generate_respondent_c8s
        when :other_party
          presenter.generate_other_party_c8s
        end

      return true unless rendered

      StringIO.new(presenter.to_pdf)
    end

    # We use `deliver_now` here, as we want the actions performed in
    # the `process` method to be executed sequentially and the whole job
    # to fail and be retried in case any of the actions fail.
    #
    def deliver_email
      NotifySubmissionMailer.with(**application_details).application_to_court(
        to_address:
      ).deliver_now
    end

    def audit_data
      c100_application.email_submission.update(
        to_address:, sent_at: Time.current
      )
    end
  end
end
