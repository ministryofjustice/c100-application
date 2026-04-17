module Steps
  module CourtOrders
    class DetailsForm < BaseForm
      include HasOneAssociationForm

      has_one_association :court_order

      NON_MOLESTATION_ATTRIBUTES = {
        non_molestation: :yes_no,
        non_molestation_case_number: :string,
        non_molestation_issue_date: :multi_param_date,
        non_molestation_length: :string,
        non_molestation_is_current: :yes_no,
        non_molestation_court_name: :string
      }.freeze.each { |name, type| attribute(name, type) }

      OCCUPATION_ATTRIBUTES = {
        occupation: :yes_no,
        occupation_case_number: :string,
        occupation_issue_date: :multi_param_date,
        occupation_length: :string,
        occupation_is_current: :yes_no,
        occupation_court_name: :string
      }.freeze.each { |name, type| attribute(name, type) }

      FORCED_MARRIAGE_PROTECTION_ATTRIBUTES = {
        forced_marriage_protection: :yes_no,
        forced_marriage_protection_case_number: :string,
        forced_marriage_protection_issue_date: :multi_param_date,
        forced_marriage_protection_length: :string,
        forced_marriage_protection_is_current: :yes_no,
        forced_marriage_protection_court_name: :string
      }.freeze.each { |name, type| attribute(name, type) }

      RESTRAINING_ATTRIBUTES = {
        restraining: :yes_no,
        restraining_case_number: :string,
        restraining_issue_date: :multi_param_date,
        restraining_length: :string,
        restraining_is_current: :yes_no,
        restraining_court_name: :string
      }.freeze.each { |name, type| attribute(name, type) }

      INJUNCTIVE_ATTRIBUTES = {
        injunctive: :yes_no,
        injunctive_case_number: :string,
        injunctive_issue_date: :multi_param_date,
        injunctive_length: :string,
        injunctive_is_current: :yes_no,
        injunctive_court_name: :string
      }.freeze.each { |name, type| attribute(name, type) }

      UNDERTAKING_ATTRIBUTES = {
        undertaking: :yes_no,
        undertaking_case_number: :string,
        undertaking_issue_date: :multi_param_date,
        undertaking_length: :string,
        undertaking_is_current: :yes_no,
        undertaking_court_name: :string
      }.freeze.each { |name, type| attribute(name, type) }

      # rubocop:disable Lint/AmbiguousOperator
      validates_inclusion_of *CourtOrderType.sym_values, in: GenericYesNo.values

      validates_presence_of(
        *NON_MOLESTATION_ATTRIBUTES.except(:non_molestation_is_current).keys,
        if: -> { non_molestation&.yes? }
      )
      validates_inclusion_of :non_molestation_is_current, in: GenericYesNo.values, if: -> { non_molestation&.yes? }

      validates_presence_of(
        *OCCUPATION_ATTRIBUTES.except(:occupation_is_current).keys,
        if: -> { occupation&.yes? }
      )
      validates_inclusion_of :occupation_is_current, in: GenericYesNo.values, if: -> { occupation&.yes? }

      validates_presence_of(
        *FORCED_MARRIAGE_PROTECTION_ATTRIBUTES.except(:forced_marriage_protection_is_current).keys,
        if: -> { forced_marriage_protection&.yes? }
      )
      validates_inclusion_of :forced_marriage_protection_is_current, in: GenericYesNo.values,
                             if: -> { forced_marriage_protection&.yes? }

      validates_presence_of(
        *RESTRAINING_ATTRIBUTES.except(:restraining_is_current).keys,
        if: -> { restraining&.yes? }
      )
      validates_inclusion_of :restraining_is_current, in: GenericYesNo.values, if: -> { restraining&.yes? }

      validates_presence_of(
        *INJUNCTIVE_ATTRIBUTES.except(:injunctive_is_current).keys,
        if: -> { injunctive&.yes? }
      )
      validates_inclusion_of :injunctive_is_current, in: GenericYesNo.values, if: -> { injunctive&.yes? }

      validates_presence_of(
        *UNDERTAKING_ATTRIBUTES.except(:undertaking_is_current).keys,
        if: -> { undertaking&.yes? }
      )
      validates_inclusion_of :undertaking_is_current, in: GenericYesNo.values, if: -> { undertaking&.yes? }

      validates *CourtOrderType.string_values.map { |name| "#{name}_issue_date" }, sensible_date: true
      # rubocop:enable Lint/AmbiguousOperator

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        record_to_persist.update(
          attributes_map
        )
      end
    end
  end
end
