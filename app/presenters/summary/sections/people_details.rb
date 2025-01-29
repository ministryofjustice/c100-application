module Summary
  module Sections
    class PeopleDetails < BaseSectionPresenter # rubocop:disable Metrics/ClassLength
      def show_header?
        false
      end

      # :nocov:
      def record_collection
        raise 'must be implemented in subclasses'
      end
      # :nocov:

      def bypass_relationships_c8?
        return nil if PrivacyChange.changes_apply?

        false
      end

      # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/BlockLength, Metrics/PerceivedComplexity
      def answers
        record_collection.map.with_index(1) do |person, index|
          if PrivacyChange.changes_apply?
            if person.are_contact_details_private == GenericYesNo::YES.to_s && person.type == 'OtherParty'
              [
                Separator.new("#{name}_index_title", index:),
                Separator.new(:c8_attached)
              ]
            else
              [
                Separator.new("#{name}_index_title", index:),
                FreeTextAnswer.new(:person_full_name, person.full_name),
                privacy_known_applicant_only(person),
                cohabit_with_children(person),
                contact_details_privacy_preferences(person),
                previous_name_answer(person),
                Answer.new(:person_sex, person.gender),
                DateAnswer.new(:person_dob, person.dob,
                               show: respondents_only && person.dob_estimate.blank?),
                DateAnswer.new(:person_dob_estimate, person.dob_estimate),
                FreeTextAnswer.new(:person_birthplace, person.birthplace),
                FreeTextAnswer.new(:person_address,
                                   data_or_private(person, person.full_address, ContactDetails::ADDRESS.to_s),
                                   show: true),
                Answer.new(:person_residence_requirement_met, person.residence_requirement_met),
                FreeTextAnswer.new(:person_residence_history, person.residence_history,
                                   show: person.residence_requirement_met == 'no'),
                FreeTextAnswer.new(:person_email,
                                   data_or_private(person, email_answer(person), ContactDetails::EMAIL.to_s)),
                FreeTextAnswer.new(:person_phone_number,
                                   data_or_private(
                                     person, phone_number_answer(person), ContactDetails::PHONE_NUMBER.to_s
                                   )),
                Answer.new(:person_voicemail_consent, person.voicemail_consent), # This shows only if a value is present
                FreeTextAnswer.new(
                  :person_relationship_to_children,
                  RelationshipsPresenter.new(c100_application).relationship_to_children(
                    person, show_person_name: false
                  )
                ),
                Partial.row_blank_space,
              ]
            end
          else
            [
              Separator.new("#{name}_index_title", index:),
              FreeTextAnswer.new(:person_full_name, person.full_name),
              FreeTextAnswer.new(:person_privacy_known, person.privacy_known.try(:capitalize)),
              contact_details_privacy_preferences(person),
              previous_name_answer(person),
              Answer.new(:person_sex, person.gender),
              DateAnswer.new(:person_dob, person.dob,
                             show: respondents_only && person.dob_estimate.blank?),
              DateAnswer.new(:person_dob_estimate, person.dob_estimate),
              FreeTextAnswer.new(:person_birthplace, person.birthplace),
              FreeTextAnswer.new(:person_address,
                                 data_or_private(person, person.full_address, ContactDetails::ADDRESS.to_s),
                                 show: true),
              Answer.new(:person_residence_requirement_met, person.residence_requirement_met),
              FreeTextAnswer.new(:person_residence_history, person.residence_history,
                                 show: person.residence_requirement_met == 'no'),
              FreeTextAnswer.new(:person_email,
                                 data_or_private(person, email_answer(person), ContactDetails::EMAIL.to_s)),
              FreeTextAnswer.new(:person_phone_number,
                                 data_or_private(
                                   person, phone_number_answer(person), ContactDetails::PHONE_NUMBER.to_s
                                 )),
              Answer.new(:person_voicemail_consent, person.voicemail_consent), # This shows only if a value is present
              FreeTextAnswer.new(
                :person_relationship_to_children,
                RelationshipsPresenter.new(c100_application).relationship_to_children(
                  person, show_person_name: false, bypass_c8: bypass_relationships_c8?
                )
              ),
              Partial.row_blank_space,
            ]
          end
        end.flatten.select(&:show?)
      end
      # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/BlockLength, Metrics/PerceivedComplexity

      private

      def data_or_private(person, data, type)
        return I18n.t('dictionary.c8_attached') if person.refuge == GenericYesNo::YES.to_s

        return I18n.t('dictionary.c8_attached') if
          person.are_contact_details_private == GenericYesNo::YES.to_s &&
          person.contact_details_private.include?(type)

        data
      end

      def cohabit_with_children(person)
        return [] unless person.type == 'OtherParty'

        FreeTextAnswer.new(:person_cohabit_other, person.cohabit_with_other.try(:capitalize), i18n_opts: {name: person.full_name})
      end

      def contact_details_privacy_preferences(person)
        return [] unless person.are_contact_details_private.present?

        if PrivacyChange.changes_apply?
          if person.type == 'OtherParty'
            [
              FreeTextAnswer.new(:person_contact_details_private,
                                 person.are_contact_details_private.try(:capitalize))
            ]
          else
            Partial.new(:privacy_preferences, {
                          are_contact_details_private: person.are_contact_details_private,
                          contact_details_private: person.contact_details_private
                        })
          end
        else
          Partial.new(:privacy_preferences, {
                        are_contact_details_private: person.are_contact_details_private,
                        contact_details_private: person.contact_details_private
                      })
        end
      end

      def privacy_known_applicant_only(person)
        return [] unless person.type == "Applicant"

        FreeTextAnswer.new(:person_privacy_known, person.privacy_known.try(:capitalize))
      end

      def previous_name_answer(person)
        if person.has_previous_name.eql?(GenericYesNo::YES.to_s)
          FreeTextAnswer.new(:person_previous_name, person.previous_name)
        else
          Answer.new(:person_previous_name, person.has_previous_name)
        end
      end

      def phone_number_answer(person)
        if person.phone_number_provided == GenericYesNo::NO.to_s
          person.phone_number_not_provided_reason
        elsif person.phone_number_unknown
          I18n.t('dictionary.unknown')
        else
          person.phone_number
        end
      end

      def email_answer(person)
        return I18n.t('dictionary.unknown') if person.email_unknown
        person.email
      end

      def respondents_only
        instance_of? Summary::Sections::RespondentsDetails
      end
    end
  end
end
