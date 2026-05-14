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
      documents.store(:c8_forms, generate_c8_documents)

      # Temporary removal
      # documents.store(:json_form, generate_json)
    end

    def generate_c8_documents
      c8_parties.map do |party_data|
        {
          key: party_data[:key],
          label: party_data[:label],
          file: generate_single_c8_pdf(
            party_data[:party],
            party_data[:section_class],
            party_data[:index]
          )
        }
      end
    end

    def c8_parties
      parties = []

      collect_c8_parties(
        parties,
        c100_application.applicants,
        Summary::Sections::C8ApplicantsDetails,
        :applicant
      )

      collect_c8_parties(
        parties,
        c100_application.respondents,
        Summary::Sections::C8RespondentsDetails,
        :respondent
      )

      collect_c8_parties(
        parties,
        c100_application.other_parties,
        Summary::Sections::C8OtherPartiesDetails,
        :other_party
      )

      parties
    end

    def collect_c8_parties(parties, collection, section_class, type)
      collection.each_with_index do |party, index|
        section = section_class.new(
          c100_application,
          party,
          index: index + 1
        )

        next unless section.show?

        parties << {
          key: :"c8_#{type}_#{index + 1}",
          label: "#{type.to_s.humanize} #{index + 1}",
          party: party,
          section_class: section_class,
          index: index
        }
      end
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
