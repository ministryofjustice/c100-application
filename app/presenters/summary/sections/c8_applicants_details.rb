module Summary
  module Sections
    class C8ApplicantsDetails < PeopleDetails
      def name
        :c8_applicants_details
      end

      def show_header?
        true
      end

      def record_collection
        c100.applicants
      end

      # Not using the superclass `PeopleDetails#answers` because, in the case of
      # applicants, most of the information is already disclosed in the C100, and here
      # we just need to show the confidential details. The superclass will show all.
      #
      # modify this to list only the private details
      def answers
        record_collection.map.with_index(1) do |person, index|
          if address(person).value.nil? && person_email(person).value.nil? && person_home_phone(person).value.nil? && person_mobile_phone(person).value.nil? && residence_history(person).value.nil?
            []
          else
            [
              Separator.new("#{name}_index_title", index: index),
              FreeTextAnswer.new(:person_full_name, person.full_name),
              address(person),
              person_email(person),
              person_home_phone(person),
              person_mobile_phone(person),
              Answer.new(:person_voicemail_consent, person.voicemail_consent),
              Partial.row_blank_space,
              residence_history(person),
              Partial.row_blank_space,
            ]
          end
        end.flatten.select(&:show?)
      end

      private

      def residence_history(person)
        value = confidential? && private?(person, ContactDetails::ADDRESS.to_s) ? person.residence_history : nil
        FreeTextAnswer.new(:person_residence_history, value)
      end

      def address(person)
        value = confidential? && private?(person, ContactDetails::ADDRESS.to_s) ? person.full_address : nil
        FreeTextAnswer.new(:person_address, value)
      end

      def person_email(person)
        value = confidential? && private?(person, ContactDetails::EMAIL.to_s) ? person.email : nil
        FreeTextAnswer.new(:person_email, value)
      end

      def person_home_phone(person)
        value = confidential? && private?(person, ContactDetails::HOME_PHONE.to_s) ? person.home_phone : nil
        FreeTextAnswer.new(:person_home_phone, value)
      end

      def person_mobile_phone(person)
        value = if confidential? && private?(person, ContactDetails::MOBILE.to_s)
                  mobile_phone_answer(person)
                end
        FreeTextAnswer.new(:person_mobile_phone, value)
      end

      def mobile_phone_answer(person)
        if person.mobile_provided == GenericYesNo::NO.to_s
          person.mobile_not_provided_reason
        else
          person.mobile_phone
        end
      end

      def confidential?
        c100.confidentiality_enabled?
      end

      def private?(person, field)
        person.contact_details_private.include? field
      end
    end
  end
end
