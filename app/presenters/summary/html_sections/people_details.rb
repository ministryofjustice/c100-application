module Summary
  module HtmlSections
    # rubocop:disable Metrics/ClassLength
    class PeopleDetails < Sections::BaseSectionPresenter
      # :nocov:
      def record_collection
        raise 'must be implemented in subclasses'
      end

      def names_path
        raise 'must be implemented in subclasses'
      end

      def personal_details_path(*)
        raise 'must be implemented in subclasses'
      end

      def contact_details_path(*)
        raise 'must be implemented in subclasses'
      end

      def address_details_path(*)
        raise 'must be implemented in subclasses'
      end

      def child_relationship_path(*)
        raise 'must be implemented in subclasses'
      end
      # :nocov:

      def answers
        record_collection.map.with_index(1) do |person, index|
          [
            Separator.new("#{name}_index_title", index:),
            FreeTextAnswer.new(:person_full_name, person.full_name, change_path: names_path),
            person_privacy_answers_group(person),
            person_personal_details_answers_group(person),
            person_address_details_answers_group(person),
            person_contact_details_answers_group(person),
            children_relationships(person),
          ].compact
        end.flatten.select(&:show?)
      end

      private

      def personal_details_questions(person)
        [
          previous_name_answer(person),
          Answer.new(:person_sex, person.gender),
          DateAnswer.new(:person_dob, person.dob),
          DateAnswer.new(:person_dob_estimate, person.dob_estimate),
          FreeTextAnswer.new(:person_birthplace, person.birthplace),
        ]
      end

      def contact_details_questions(person)
        [
          Answer.new(:person_email_provided, person.email_provided),
          FreeTextAnswer.new(:person_email, person.email, { show: true }),
          Answer.new(:email_keep_private, person.email_private? && (person.email_private? ? 'yes' : 'no')),
          FreeTextAnswer.new(:person_home_phone, person.home_phone, { show: true }),
          Answer.new(:phone_keep_private, person.home_phone_private? && (person.home_phone_private? ? 'yes' : 'no')),
          FreeTextAnswer.new(:person_mobile_phone, mobile_phone_answer(person), { show: true }),
          Answer.new(:mobile_keep_private, person.mobile_private? && (person.mobile_private? ? 'yes' : 'no')),
          Answer.new(:person_voicemail_consent, person.voicemail_consent), # This shows only if a value is present
        ]
      end

      def address_details_questions(person)
        [
          FreeTextAnswer.new(:person_address, person.full_address),
          Answer.new(:person_address_unknown, person.address_unknown), # This shows only if a value is present
          Answer.new(:person_residence_requirement_met, person.residence_requirement_met),
          Answer.new(:residence_keep_private, person.address_private? && (person.address_private? ? 'yes' : 'no')),
          FreeTextAnswer.new(:person_residence_history, person.residence_history)
        ]
      end

      def previous_name_answer(person)
        if person.has_previous_name.eql?(GenericYesNo::YES.to_s)
          FreeTextAnswer.new(:person_previous_name, person.previous_name)
        else
          Answer.new(:person_previous_name, person.has_previous_name)
        end
      end

      def person_privacy_answers_group(person)
        return [] unless person.privacy_known

        #   if person.type == 'Applicant'
        #     return [] unless person.privacy_known
        #
        #     applicant_privacy_answers(person)
        #   elsif person.type == 'OtherParty'
        #     other_party_privacy_answers(person)
        #   end
        # end
        #
        # def applicant_privacy_answers(person)
        if ConfidentialOption.changes_apply?
          [
            FreeTextAnswer.new(:person_privacy_known, person.privacy_known.capitalize,
                               change_path: edit_steps_applicant_privacy_known_path(person)),
            FreeTextAnswer.new(:person_contact_details_private,
                               privacy_preferences_answer(person),
                               change_path: edit_steps_applicant_privacy_preferences_path(person)),
            FreeTextAnswer.new(:refuge, person.refuge.capitalize,
                               change_path: edit_steps_applicant_refuge_path(person)),
          ]
        else
          [
            FreeTextAnswer.new(:person_privacy_known, person.privacy_known.capitalize,
                               change_path: edit_steps_applicant_privacy_known_path(person)),
            FreeTextAnswer.new(:person_contact_details_private,
                               privacy_preferences_answer(person),
                               change_path: edit_steps_applicant_privacy_preferences_path(person))
          ]
        end
      end

      # def other_party_privacy_answers(person)
      #   [
      #     FreeTextAnswer.new(:person_cohabit_other, person.cohabit_with_other.try(:capitalize),
      #                        change_path: edit_steps_other_party_children_cohabit_other_path(person),
      #                        i18n_opts: {name: person.full_name}),
      #     FreeTextAnswer.new(:person_contact_details_private,
      #                        person.are_contact_details_private.try(:capitalize),
      #                        change_path: edit_steps_other_party_privacy_preferences_path(person))
      #   ]
      # end

      def privacy_preferences_answer(person)
        if person.are_contact_details_private == GenericYesNo::YES.to_s
          person.contact_details_private.map do |detail|
            ContactDetails.new(detail).long_name
          end.join(', ')
        else
          GenericYesNo::NO.to_s.capitalize
        end
      end

      def person_personal_details_answers_group(person)
        AnswersGroup.new(
          :person_personal_details,
          personal_details_questions(person),
          change_path: personal_details_path(person)
        )
      end

      def person_address_details_answers_group(person)
        AnswersGroup.new(
          :person_address_details,
          address_details_questions(person),
          change_path: address_details_path(person)
        )
      end

      def person_contact_details_answers_group(person)
        return unless contact_details_path(person)

        AnswersGroup.new(
          :person_contact_details,
          contact_details_questions(person),
          change_path: contact_details_path(person)
        )
      end

      def children_relationships(person)
        person.relationships.map do |rel|
          [
            Answer.new(
              :relationship_to_child,
              (rel.relation unless rel.relation.eql?(Relation::OTHER.to_s)),
              change_path: child_relationship_path(person, rel.minor),
              i18n_opts: {child_name: rel.minor.full_name}
            ),
            # The free text value only shows when the relation is `other`
            FreeTextAnswer.new(
              :relationship_to_child,
              rel.relation_other_value,
              change_path: child_relationship_path(person, rel.minor),
              i18n_opts: {child_name: rel.minor.full_name}
            ),
            # The following questions only show if present and only apply
            # to applicant-child relationships (main children)
            permission_questions_for(rel)
          ]
        end.flatten
      end

      def permission_questions_for(relationship)
        # As these questions are linear, if the first one is `nil` there is no point
        # in looping through the rest, as those ones will be also `nil`
        #
        return [] unless relationship.try!(permission_attributes.first)

        i18n_opts = {
          applicant_name: relationship.person.full_name,
          child_name: relationship.minor.full_name,
        }

        permission_attributes.map do |attr|
          Answer.new(
            "child_permission_#{attr}",
            relationship.try!(attr),
            change_path: steps_permission_question_path(question_name: attr, relationship_id: relationship),
            i18n_opts:
          )
        end
      end

      def permission_attributes
        Relationship::PERMISSION_ATTRIBUTES
      end

      def mobile_phone_answer(person)
        if person.mobile_provided == GenericYesNo::NO.to_s
          person.mobile_not_provided_reason
        else
          person.mobile_phone
        end
      end
    end
    # rubocop:enable Metrics/ClassLength
  end
end
