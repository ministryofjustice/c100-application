module Summary
  module JsonSections
    class AttendingHearing < Sections::BaseJsonPresenter
      attr_reader :c100_application
      attr_reader :section_hash

      alias_attribute :c100, :c100_application

      def initialize(c100_application)
        @c100_application = c100_application
        @section_hash = attending_hearing
      end

      def attending_hearing
        {isWelshNeeded:  welsh_needed,
         welshNeeds: [welsh_details],
         isInterpreterNeeded: interpreter_needed,
         interpreterNeeds: interpreter_details,
         isSpecialArrangementsRequired: special_arrangements,
         specialArrangementsRequired: special_arrangements_details,
         isDisabilityPresent: disability_present,
         adjustmentsRequired: disability_requirements_details,
         isIntermediaryNeeded: intermediary_help}
      end

      def welsh_needed
        arrangement = c100_application.court_arrangement
        return 'No' if arrangement.blank?
        yes_no(arrangement.language_options.include?(LanguageHelp::WELSH_LANGUAGE.to_s))
      end

      def welsh_details
        arrangement = c100_application.court_arrangement
        return 'No' if arrangement.blank?
        arrangement.welsh_language_details
      end

      def interpreter_needed
        arrangement = c100_application.court_arrangement
        return 'No' if arrangement.blank?
        yes_no(arrangement.language_options.include?(LanguageHelp::LANGUAGE_INTERPRETER.to_s))
      end

      def interpreter_details
        arrangement = c100_application.court_arrangement
        return unless arrangement
        return arrangement.language_interpreter_details if arrangement.language_options.blank?
        return 'No' if arrangement.blank?
        list = arrangement.language_options
        list << arrangement.language_interpreter_details
        list.join(', ')
      end

      def special_arrangements
        arrangement = c100_application.court_arrangement
        return 'No' if arrangement.blank?
        yes_no(!arrangement.special_arrangements.blank?)
      end

      def special_arrangements_details
        arrangement = c100_application.court_arrangement
        return unless arrangement
        return arrangement.special_arrangements_details if arrangement.special_arrangements.blank?
        list = arrangement.special_arrangements
        list << arrangement.special_arrangements_details.to_s
        list.join(', ')
      end

      def disability_present
        arrangement = c100_application.court_arrangement
        return 'No' if arrangement.blank?
        yes_no(!arrangement.special_assistance.blank?)
      end

      def disability_requirements_details
        arrangement = c100_application.court_arrangement
        return unless arrangement
        return arrangement.special_assistance_details if arrangement.special_assistance.blank?
        list = arrangement.special_assistance
        list << arrangement.special_assistance_details.to_s
        list.join(', ')
      end

      def intermediary_help
        arrangement = c100_application.court_arrangement
        return 'No' if arrangement.blank?
        arrangement.intermediary_help
      end
    end
  end
end
