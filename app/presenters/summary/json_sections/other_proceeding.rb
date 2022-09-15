module Summary
  module JsonSections
    class OtherProceeding
      attr_reader :c100_application
      attr_reader :section_hash

      alias_attribute :c100, :c100_application

      def initialize(c100_application)
        @c100_application = c100_application
        @section_hash = other_proceedings
      end

      def other_proceedings
        {
          previousOrOngoingProceedingsForChildren: c100_application.children_previous_proceedings,
          existingProceedings: existing_proceeding
        }
      end

      def existing_proceeding
        return nil if c100_application.court_proceeding.blank?
        c100_application.court_proceeding.attributes.select do |key, _value|
          key != 'id' && key != 'c100_application_id'
        end
      end
    end
  end
end
