module Summary
  module Sections
    class C8RespondentsDetails < PeopleDetails
      attr_reader :person, :index

      def initialize(c100, person, index: 1)
        super(c100)
        @person = person
        @index = index
      end

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

      # rubocop:disable Metrics/AbcSize
      def answers
        return super unless PrivacyChange.changes_apply?

        return [] unless person.are_contact_details_private == GenericYesNo::YES.to_s

        [
          Separator.new("#{name}_index_title", index:),
          Answer.new(:respondent_refuge, person.refuge),
          FreeTextAnswer.new(:person_full_name, person.full_name),
          FreeTextAnswer.new(:person_address, person.full_address),
          FreeTextAnswer.new(
            :person_residence_history,
            person.residence_history,
            show: person.residence_requirement_met == 'no'
          ),
          FreeTextAnswer.new(:person_email, person.email),
          FreeTextAnswer.new(:person_phone_number, person.phone_number),
          Partial.row_blank_space
        ].select(&:show?)
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
