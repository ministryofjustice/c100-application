module Summary
  class JsonPresenter
    attr_reader :c100_application

    def initialize(c100_application)
      @c100_application = c100_application
    end

    def generate
      create_hash
    rescue StandardError => e
      Sentry.capture_exception(e, tags: { id: @c100_application.id, ref: @c100_application.reference_code })
      @c100_hash = [{}]
    end

    # rubocop:disable Metrics/AbcSize
    def create_hash
      @c100_hash = [{
        solicitor: [JsonSections::Solicitor.new(c100_application).section_hash],
        header: {},
        id: @c100_application.id,
        children: JsonSections::Child.new(c100_application).section_hash,
        applicants: JsonSections::Applicant.new(c100_application).section_hash,
        respondents: JsonSections::Respondent.new(c100_application).section_hash,
        typeOfApplication: JsonSections::TypeOfApplication.new(c100_application).section_hash,
        hearingUrgency: JsonSections::HearingUrgency.new(c100_application).section_hash,
        miam: JsonSections::Miam.new(c100_application).section_hash,
        allegationsOfHarm: JsonSections::AllegationOfHarm.new(c100_application).section_hash,
        otherPeopleInTheCase: {},
        otherProceedings: JsonSections::OtherProceeding.new(c100_application).section_hash,
        attendingTheHearing: JsonSections::AttendingHearing.new(c100_application).section_hash,
        internationalElement: JsonSections::InternationalElement.new(c100_application).section_hash,
        litigationCapacity: JsonSections::LitigationCapacity.new(c100_application).section_hash,
        feeAmount: fee_amount,
        # familyManNumber: {},
        # others: {},
        # events: {}
      }]
    end
    # rubocop:enable Metrics/AbcSize

    def json_file
      json_file = Tempfile.new
      json_file << @c100_hash.to_json
      json_file.rewind
      json_file
    end

    def filename
      'C100 child arrangements application.json'.freeze
    end

    private

    def fee_amount
      amount = format("%.2f", (Rails.configuration.x.court_fee.amount_in_pence / 100))
      "£#{amount}"
    end
  end
end
