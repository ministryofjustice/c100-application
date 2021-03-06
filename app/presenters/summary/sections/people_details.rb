module Summary
  module Sections
    class PeopleDetails < BaseSectionPresenter
      def show_header?
        false
      end

      # :nocov:
      def record_collection
        raise 'must be implemented in subclasses'
      end
      # :nocov:

      # Override in subclasses to disable the hiding of relationships.
      # Right now, this is only needed in `sections/c8_other_parties_details.rb`
      def bypass_relationships_c8?
        false
      end

      # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      def answers
        record_collection.map.with_index(1) do |person, index|
          [
            Separator.new("#{name}_index_title", index: index),
            FreeTextAnswer.new(:person_full_name, person.full_name),
            previous_name_answer(person),
            Answer.new(:person_sex, person.gender),
            DateAnswer.new(:person_dob, person.dob),
            FreeTextAnswer.new(:person_age_estimate, person.age_estimate), # This shows only if a value is present
            FreeTextAnswer.new(:person_birthplace, person.birthplace),
            FreeTextAnswer.new(:person_address, person.full_address, show: true),
            Answer.new(:person_residence_requirement_met, person.residence_requirement_met),
            FreeTextAnswer.new(:person_residence_history, person.residence_history),
            FreeTextAnswer.new(:person_email, person.email),
            FreeTextAnswer.new(:person_home_phone, person.home_phone),
            FreeTextAnswer.new(:person_mobile_phone, person.mobile_phone),
            Answer.new(:person_voicemail_consent, person.voicemail_consent), # This shows only if a value is present
            FreeTextAnswer.new(
              :person_relationship_to_children,
              RelationshipsPresenter.new(c100_application).relationship_to_children(
                person, show_person_name: false, bypass_c8: bypass_relationships_c8?
              )
            ),
            Partial.row_blank_space,
          ]
        end.flatten.select(&:show?)
      end
      # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

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
