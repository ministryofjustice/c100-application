module Summary
  module Sections
    class C8OtherPartiesDetails < PeopleDetails
      def name
        :c8_other_parties_details
      end

      def show_header?
        true
      end

      def record_collection
        c100.other_parties
      end

      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/MethodLength
      def answers
        record_collection.map.with_index(1) do |person, index|
          if person.are_contact_details_private == GenericYesNo::YES.to_s
            [
              Separator.new("#{name}_index_title", index:),
              FreeTextAnswer.new(:person_full_name, person.full_name),
              previous_name_answer(person),
              Answer.new(:person_sex, person.gender),
              DateAnswer.new(:person_dob, person.dob,
                             show: respondents_only && person.dob_estimate.blank?),
              DateAnswer.new(:person_dob_estimate, person.dob_estimate),
              FreeTextAnswer.new(:person_address, person.full_address),
              FreeTextAnswer.new(
                :person_relationship_to_children,
                RelationshipsPresenter.new(c100_application).relationship_to_children(
                  person, show_person_name: false, bypass_c8: true
                )
              ),
              Partial.row_blank_space
            ]
          else
            []
          end
        end.flatten.select(&:show?)
      end
      # rubocop:enable Metrics/AbcSize
      # rubocop:enable Metrics/MethodLength

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
