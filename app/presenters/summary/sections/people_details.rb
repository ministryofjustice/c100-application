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

      # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/BlockLength
      def answers
        record_collection.map.with_index(1) do |person, index|
          [
            Separator.new("#{name}_index_title", index: index),
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
            Answer.new(:residence_keep_private, person.residence_keep_private),
            FreeTextAnswer.new(:person_residence_history, person.residence_history,
                               show: person.residence_requirement_met == 'no'),
            FreeTextAnswer.new(:person_email,
                               data_or_private(person, person.email, ContactDetails::EMAIL.to_s)),
            Answer.new(:email_keep_private, person.email_keep_private),
            FreeTextAnswer.new(:person_home_phone,
                               data_or_private(person, person.home_phone, ContactDetails::HOME_PHONE.to_s)),
            Answer.new(:phone_keep_private, person.phone_keep_private),
            FreeTextAnswer.new(:person_mobile_phone,
                               data_or_private(
                                 person, mobile_phone_answer(person), ContactDetails::MOBILE.to_s
                               )),
            Answer.new(:mobile_keep_private, person.mobile_keep_private),
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
      # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/BlockLength

      private

      def data_or_private(person, data, type)
        return I18n.t('dictionary.c8_attached') if
          person.are_contact_details_private == 'yes' &&
          person.contact_details_private.include?(type)
        data
      end

      def contact_details_privacy_preferences(person)
        return [] unless person.are_contact_details_private.present?
        Partial.new(:privacy_preferences, {
                      are_contact_details_private: person.are_contact_details_private,
          contact_details_private: person.contact_details_private
                    })
      end

      def previous_name_answer(person)
        if person.has_previous_name.eql?(GenericYesNo::YES.to_s)
          FreeTextAnswer.new(:person_previous_name, person.previous_name)
        else
          Answer.new(:person_previous_name, person.has_previous_name)
        end
      end

      def mobile_phone_answer(person)
        if person.mobile_provided == GenericYesNo::NO.to_s
          person.mobile_not_provided_reason
        else
          person.mobile_phone
        end
      end

      def respondents_only
        instance_of? Summary::Sections::RespondentsDetails
      end
    end
  end
end
