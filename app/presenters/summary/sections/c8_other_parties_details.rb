module Summary
  module Sections
    class C8OtherPartiesDetails < PeopleDetails
      attr_reader :person, :index

      def initialize(c100, person, index: 1)
        super(c100)
        @person = person
        @index = index
      end

      def name
        :c8_other_parties_details
      end

      def show_header?
        true
      end

      def bypass_relationships_c8?
        return nil if PrivacyChange.changes_apply?

        true
      end

      def answers
        return [] unless privacy_required?

        final_output.select(&:show?)
      end

      private

      def privacy_required?
        identity_private? || contact_or_refuge?
      end

      def identity_private?
        person.are_identity_details_private == GenericYesNo::YES.to_s
      end

      def contact_or_refuge?
        person.are_contact_details_private == GenericYesNo::YES.to_s ||
          person.refuge != GenericYesNo::NO.to_s
      end

      def final_output
        identity_private? && !contact_or_refuge? ? short_output : full_output
      end

      def short_output
        [
          Separator.new("#{name}_index_title", index: index),
          Answer.new(:other_party_refuge, person.refuge),
          FreeTextAnswer.new(:person_full_name, person.full_name)
        ]
      end

      def full_output
        short_output + [
          FreeTextAnswer.new(
            :person_cohabit_other,
            person.cohabit_with_other&.capitalize,
            i18n_opts: { name: person.full_name }
          ),
          previous_name_answer,
          Answer.new(:person_sex, person.gender),
          dob_answer,
          DateAnswer.new(:person_dob_estimate, person.dob_estimate),
          FreeTextAnswer.new(:person_address, person.full_address),
          relationship_answer,
          Partial.row_blank_space
        ]
      end

      def dob_answer
        DateAnswer.new(:person_dob, person.dob, show: respondents_only && person.dob_estimate.blank?)
      end

      def relationship_answer
        FreeTextAnswer.new(
          :person_relationship_to_children,
          RelationshipsPresenter.new(c100_application).relationship_to_children(
            person,
            show_person_name: false,
            bypass_c8: true
          )
        )
      end

      def previous_name_answer
        if person.has_previous_name == GenericYesNo::YES.to_s
          FreeTextAnswer.new(:person_previous_name, person.previous_name)
        else
          Answer.new(:person_previous_name, person.has_previous_name)
        end
      end
    end
  end
end
