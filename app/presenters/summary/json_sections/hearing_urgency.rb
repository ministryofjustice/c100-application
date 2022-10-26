module Summary
  module JsonSections
    class HearingUrgency
      attr_reader :c100_application
      attr_reader :section_hash

      alias_attribute :c100, :c100_application

      def initialize(c100_application)
        @c100_application = c100_application
        @section_hash = hearing_urgency
      end

      def hearing_urgency
        {isCaseUrgent: c100_application.urgent_hearing,
         setOutReasonsBelow: c100_application.urgent_hearing_details,
         caseUrgencyTimeAndReason: c100_application.urgent_hearing_when,
         # effortsMadeWithRespondents: nil,
         doYouNeedAWithoutNoticeHearing: c100_application.without_notice,
         # areRespondentsAwareOfProceedings: "No",
         reasonsForApplicationWithoutNotice: c100_application.without_notice_details,
         doYouRequireAHearingWithReducedNotice: c100_application.urgent_hearing_short_notice}
      end
    end
  end
end
