module Steps
  module CourtOrders
    class DetailsForm < BaseForm
      include GovUkDateFields::ActsAsGovUkDate

      ORDER_NAMES = [
        :non_molestation,
        :occupation,
        :forced_marriage_protection,
        :restraining,
        :injunctive,
        :undertaking
      ].freeze

      NON_MOLESTATION_ATTRIBUTES = {
        non_molestation: YesNo,
        non_molestation_issue_date: Date,
        non_molestation_length: String,
        non_molestation_is_current: YesNo,
        non_molestation_court_name: String
      }.freeze.each { |name, type| attribute(name, type) }

      OCCUPATION_ATTRIBUTES = {
        occupation: YesNo,
        occupation_issue_date: Date,
        occupation_length: String,
        occupation_is_current: YesNo,
        occupation_court_name: String
      }.freeze.each { |name, type| attribute(name, type) }

      FORCED_MARRIAGE_PROTECTION_ATTRIBUTES = {
        forced_marriage_protection: YesNo,
        forced_marriage_protection_issue_date: Date,
        forced_marriage_protection_length: String,
        forced_marriage_protection_is_current: YesNo,
        forced_marriage_protection_court_name: String
      }.freeze.each { |name, type| attribute(name, type) }

      RESTRAINING_ATTRIBUTES = {
        restraining: YesNo,
        restraining_issue_date: Date,
        restraining_length: String,
        restraining_is_current: YesNo,
        restraining_court_name: String
      }.freeze.each { |name, type| attribute(name, type) }

      INJUNCTIVE_ATTRIBUTES = {
        injunctive: YesNo,
        injunctive_issue_date: Date,
        injunctive_length: String,
        injunctive_is_current: YesNo,
        injunctive_court_name: String
      }.freeze.each { |name, type| attribute(name, type) }

      UNDERTAKING_ATTRIBUTES = {
        undertaking: YesNo,
        undertaking_issue_date: Date,
        undertaking_length: String,
        undertaking_is_current: YesNo,
        undertaking_court_name: String
      }.freeze.each { |name, type| attribute(name, type) }

      # rubocop:disable AmbiguousOperator
      acts_as_gov_uk_date *ORDER_NAMES.map { |name| "#{name}_issue_date" }

      validates_inclusion_of *ORDER_NAMES, in: GenericYesNo.values

      validates_presence_of  *NON_MOLESTATION_ATTRIBUTES.keys, if: -> { non_molestation&.yes? }
      validates_inclusion_of :non_molestation_is_current, in: GenericYesNo.values, if: -> { non_molestation&.yes? }

      validates_presence_of  *OCCUPATION_ATTRIBUTES.keys, if: -> { occupation&.yes? }
      validates_inclusion_of :occupation_is_current, in: GenericYesNo.values, if: -> { occupation&.yes? }

      validates_presence_of  *FORCED_MARRIAGE_PROTECTION_ATTRIBUTES.keys, if: -> { forced_marriage_protection&.yes? }
      validates_inclusion_of :forced_marriage_protection_is_current, in: GenericYesNo.values, if: -> { forced_marriage_protection&.yes? }

      validates_presence_of  *RESTRAINING_ATTRIBUTES.keys, if: -> { restraining&.yes? }
      validates_inclusion_of :restraining_is_current, in: GenericYesNo.values, if: -> { restraining&.yes? }

      validates_presence_of  *INJUNCTIVE_ATTRIBUTES.keys, if: -> { injunctive&.yes? }
      validates_inclusion_of :injunctive_is_current, in: GenericYesNo.values, if: -> { injunctive&.yes? }

      validates_presence_of  *UNDERTAKING_ATTRIBUTES.keys, if: -> { undertaking&.yes? }
      validates_inclusion_of :undertaking_is_current, in: GenericYesNo.values, if: -> { undertaking&.yes? }
      # rubocop:enable AmbiguousOperator

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        orders_record = c100_application.court_order || c100_application.build_court_order
        orders_record.update(
          attributes_map
        )
      end
    end
  end
end
