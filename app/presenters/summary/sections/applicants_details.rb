module Summary
  module Sections
    class ApplicantsDetails < PeopleDetails
      def name
        :applicants_details
      end

      def record_collection
        c100.applicants
      end
    end
  end
end
