module Summary
  class HtmlPresenter
    attr_reader :c100_application

    def initialize(c100_application)
      @c100_application = c100_application
    end

    def sections
      [
        *miam_questions,
        *safety_and_abuse_questions,
        HtmlSections::NatureOfApplication.new(c100_application),
        HtmlSections::Alternatives.new(c100_application),
        *children_sections,
        *people_sections,
        HtmlSections::ChildrenResidence.new(c100_application),
        HtmlSections::OtherCourtCases.new(c100_application),
        *urgent_and_without_notice_sections,
        HtmlSections::InternationalElement.new(c100_application),
        HtmlSections::ApplicationReasons.new(c100_application),
        *litigation_and_assistance_sections,
        *submission_and_payment_sections,
      ].flatten.select(&:show?)
    end

    def errors
      FulfilmentErrorsPresenter.new(c100_application).errors
    end

    def before_submit_warning
      ['.submit_warning', submission_type].join('.')
    end

    def submit_button_label
      ['submit_application', submission_type].join('.')
    end

    private

    def miam_questions
      [
        HtmlSections::MiamRequirement.new(c100_application),
        HtmlSections::MiamAttendance.new(c100_application),
        HtmlSections::MiamExemptions.new(c100_application),
      ]
    end

    def safety_and_abuse_questions
      [
        HtmlSections::SafetyConcerns.new(c100_application),
        HtmlSections::Abduction.new(c100_application),
        HtmlSections::ChildrenAbuseDetails.new(c100_application),
        HtmlSections::ApplicantAbuseDetails.new(c100_application),
        HtmlSections::CourtOrders.new(c100_application),
        HtmlSections::SafetyContact.new(c100_application),
      ]
    end

    def children_sections
      [
        HtmlSections::ChildrenDetails.new(c100_application),
        HtmlSections::ChildrenFurtherInformation.new(c100_application),
        HtmlSections::OtherChildrenDetails.new(c100_application),
      ]
    end

    def people_sections
      [
        HtmlSections::ApplicantsDetails.new(c100_application),
        HtmlSections::SolicitorDetails.new(c100_application),
        HtmlSections::RespondentsDetails.new(c100_application),
        HtmlSections::OtherPartiesDetails.new(c100_application),
      ]
    end

    def urgent_and_without_notice_sections
      [
        HtmlSections::UrgentHearingDetails.new(c100_application),
        HtmlSections::WithoutNoticeDetails.new(c100_application),
      ]
    end

    def litigation_and_assistance_sections
      [
        HtmlSections::LitigationCapacity.new(c100_application),
        HtmlSections::AttendingCourtV2.new(c100_application),
      ]
    end

    def submission_and_payment_sections
      [
        HtmlSections::Submission.new(c100_application),
        HtmlSections::Payment.new(c100_application),
      ]
    end

    def submission_type
      c100_application.submission_type || SubmissionType::PRINT_AND_POST
    end
  end
end
