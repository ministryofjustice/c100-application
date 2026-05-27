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

      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/MethodLength
      # rubocop:disable Metrics/PerceivedComplexity
      def answers
        return super unless PrivacyChange.changes_apply?

        identity_private = person.are_identity_details_private == GenericYesNo::YES.to_s
        contact_private  = person.are_contact_details_private == GenericYesNo::YES.to_s
        in_refuge        = person.refuge != GenericYesNo::NO.to_s
        contact_or_refuge = contact_private || in_refuge

        return [] unless identity_private || contact_or_refuge

        if identity_private && !contact_or_refuge
          [
            Separator.new("#{name}_index_title", index:),
            Answer.new(:refuge, person.refuge),
            FreeTextAnswer.new(:person_full_name, person.full_name),
          ]
        else
          [
            Separator.new("#{name}_index_title", index:),
            Answer.new(:refuge, person.refuge),
            FreeTextAnswer.new(:person_full_name, person.full_name),
            FreeTextAnswer.new(
              :person_cohabit_other,
              person.cohabit_with_other.try(:capitalize),
              i18n_opts: { name: person.full_name }
            ),
            previous_name_answer(person),
            Answer.new(:person_sex, person.gender),
            DateAnswer.new(
              :person_dob,
              person.dob,
              show: respondents_only && person.dob_estimate.blank?
            ),
            DateAnswer.new(:person_dob_estimate, person.dob_estimate),
            FreeTextAnswer.new(:person_address, person.full_address),
            FreeTextAnswer.new(
              :person_relationship_to_children,
              RelationshipsPresenter.new(c100_application).relationship_to_children(
                person,
                show_person_name: false,
                bypass_c8: true
              )
            ),
            Partial.row_blank_space
          ].select(&:show?)
        end
      end
      # rubocop:enable Metrics/AbcSize
      # rubocop:enable Metrics/MethodLength
      # rubocop:enable Metrics/PerceivedComplexity

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
