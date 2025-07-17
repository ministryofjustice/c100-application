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
          if empty_data?(person)
            []
          else
            [
              Separator.new("#{name}_index_title", index:),
              Answer.new(:refuge, person.refuge),
              FreeTextAnswer.new(:person_full_name, person.full_name),
              address(person),
              person_email(person),
              person_phone_number(person),
              Answer.new(:person_voicemail_consent, person.voicemail_consent),
              Partial.row_blank_space,
              Partial.row_blank_space,
            ]
          end
        end.flatten.select(&:show?)
      end

      private

      def address(person)
        value = person.full_address if in_refuge?(person) || (confidential? && private?(person, ContactDetails::ADDRESS.to_s))
        FreeTextAnswer.new(:person_address, value)
      end

      def person_email(person)
        value = person.email if in_refuge?(person) || (confidential? && private?(person, ContactDetails::EMAIL.to_s))
        FreeTextAnswer.new(:person_email, value)
      end

      def person_phone_number(person)
        value = phone_number_answer(person) if in_refuge?(person) || (
          confidential? && private?(
            person,
            ContactDetails::PHONE_NUMBER.to_s
          )
        )
        FreeTextAnswer.new(:person_phone_number, value)
      end

      def phone_number_answer(person)
        if person.phone_number_provided == GenericYesNo::NO.to_s
          person.phone_number_not_provided_reason
        else
          person.phone_number
        end
      end

      def empty_data?(person)
        address(person).value.nil? &&
          person_email(person).value.nil? &&
          person_phone_number(person).value.nil?
      end

      def confidential?
        c100.confidentiality_enabled?
      end

      def private?(person, field)
        person.contact_details_private.include? field
      end

      def in_refuge?(person)
        person.refuge == GenericYesNo::YES.to_s
      end
    end
  end
end
