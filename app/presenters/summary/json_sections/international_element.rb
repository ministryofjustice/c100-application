module Summary
  module JsonSections
    class InternationalElement
      attr_reader :c100_application
      attr_reader :section_hash

      alias_attribute :c100, :c100_application

      def initialize(c100_application)
        @c100_application = c100_application
        @section_hash = international_element
      end

      def international_element
        {
          habitualResidentInOtherState: c100_application.international_resident,
          habitualResidentInOtherStateGiveReason: c100_application.international_resident_details,
          jurisdictionIssueGiveReason: c100_application.international_jurisdiction_details,
          jurisdictionIssue: c100_application.international_jurisdiction,
          requestToForeignAuthority: c100_application.international_request,
          requestToForeignAuthorityGiveReason: c100_application.international_request_details
        }
      end
    end
  end
end
