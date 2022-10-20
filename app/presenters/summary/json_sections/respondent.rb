module Summary
  module JsonSections
    class Respondent
      attr_reader :c100_application
      attr_reader :section_hash

      alias_attribute :c100, :c100_application

      def initialize(c100_application)
        @c100_application = c100_application
        @section_hash = respondents
      end

      def respondents
        respondents_data = []
        c100_application.respondents.each do |respondent|
          respondents_data << respondent_json(respondent)
        end
        respondents_data
      end

      # rubocop:disable Metrics/AbcSize
      def respondent_json(respondent)
        {
          firstName: respondent.first_name,
          lastName: respondent.last_name,
          previousName: respondent.previous_name,
          dateOfBirth: respondent_dob(respondent),
          isDateOfBirthKnown: yes_no(respondent.dob.present?),
          gender: respondent.gender,
          email: respondent.email,
          phoneNumber: respondent.mobile_phone,
          isPlaceOfBirthKnown: yes_no(respondent.birthplace.present?),
          placeOfBirth: respondent.birthplace,
          isCurrentAddressKnown: yes_no(respondent.address_data.present?),
          address: map_address_data(respondent.address_data),
          isAtAddressLessThan5Years: "No",
          addressLivedLessThan5YearsDetails: nil,
          isAddressConfidential: respondent.residence_keep_private,
          canYouProvidePhoneNumber: yes_no(!respondent.mobile_keep_private),
          canYouProvideEmailAddress: yes_no(!respondent.email_keep_private)
        }
      end
      # rubocop:enable Metrics/AbcSize

      def map_address_data(address_data)
        {
          County: nil,
          Country: address_data["country"],
          PostCode: address_data["postcode"],
          PostTown: address_data["town"],
          AddressLine1: address_data["address_line_1"],
          AddressLine2: address_data["address_line_2"],
          AddressLine3: address_data["address_line_3"]
        }
      end

      def yes_no(value)
        return 'No' if value == false
        'Yes' if value == true
      end

      def respondent_dob(respondent)
        dob = respondent.try(:dob)
        dob&.to_fs(:db)
      end
    end
  end
end
