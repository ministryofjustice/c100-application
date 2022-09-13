module Summary
  module JsonSections
    class Applicant < Sections::BaseJsonPresenter
      attr_reader :c100_application
      attr_reader :section_hash

      alias_attribute :c100, :c100_application

      def initialize(c100_application)
        super()
        @c100_application = c100_application
        @section_hash = applicants
      end

      def applicants
        applicants_data = []
        c100_application.applicants.each do |applicant|
          applicants_data << applicant_json(applicant)
        end
        applicants_data
      end

      def applicant_json(applicant)
        {
          firstName: applicant.first_name,
          lastName: applicant.last_name,
          previousName: applicant.previous_name,
          dateOfBirth: applicant.dob.to_fs(:db),
          gender: applicant.gender,
          email: applicant.email,
          phoneNumber: applicant.mobile_phone,
          placeOfBirth: applicant.birthplace,
          address: map_address_data(applicant.address_data),
          isAtAddressLessThan5Years: "No",
          addressLivedLessThan5YearsDetails: nil,
          isAddressConfidential: applicant.residence_keep_private,
          isPhoneNumberConfidential: yes_no(applicant.mobile_keep_private),
          isEmailAddressConfidential: yes_no(applicant.email_keep_private)
        }
      end
    end
  end
end
