module Summary
  module Sections
    class C8RespondentsDetails < PeopleDetails
      def name
        :c8_respondents_details
      end

      def show_header?
        true
      end

      def bypass_relationships_c8?
        return nil if PrivacyChange.changes_apply?

        true
      end

      def record_collection
        c100.respondents
      end

      # rubocop:disable Metrics/AbcSize
      def answers
        return super unless PrivacyChange.changes_apply?

        record_collection.map.with_index(1) do |person, index|
          if person.are_contact_details_private == GenericYesNo::YES.to_s
            [
              Separator.new("#{name}_index_title", index:),
              Answer.new(:respondent_refuge, person.refuge),
              FreeTextAnswer.new(:person_full_name, person.full_name),
              previous_name_answer(person),
              FreeTextAnswer.new(:person_address, person.full_address),
              FreeTextAnswer.new(:person_residence_requirement_met, person.residence_requirement_met),
              FreeTextAnswer.new(:person_residence_history, person.residence_history,
                                 show: person.residence_requirement_met == 'no'),
              FreeTextAnswer.new(:person_email, person.email),
              FreeTextAnswer.new(:person_phone_number, person.phone_number),
              Partial.row_blank_space
            ]
          else
            []
          end
        end.flatten.select(&:show?)
      end
      # rubocop:enable Metrics/AbcSize

      private

      def previous_name_answer(person)
        if person.has_previous_name.eql?(GenericYesNo::YES.to_s)
          FreeTextAnswer.new(:person_previous_name, person.previous_name)
        else
          Answer.new(:person_previous_name, person.has_previous_name)
        end
      end
    end
  end
end
