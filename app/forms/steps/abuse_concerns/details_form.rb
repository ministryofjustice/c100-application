module Steps
  module AbuseConcerns
    class DetailsForm < BaseAbuseForm
      attribute :behaviour_description, String
      attribute :behaviour_start, String
      attribute :behaviour_ongoing, String
      attribute :behaviour_stop, String
      # TODO: below attributes to be implemented in follow-up PR
      # attribute :asked_for_help, String
      # attribute :help_party, String
      # attribute :help_provided, String
      # attribute :help_description, String

      def self.behaviour_ongoing_choices
        GenericYesNo.values.map(&:to_s)
      end
      validates_inclusion_of :behaviour_ongoing, in: behaviour_ongoing_choices

      validates_presence_of :behaviour_description
      validates_presence_of :behaviour_start
      validates_presence_of :behaviour_stop, if: :behaviour_not_ongoing?

      private

      def behaviour_not_ongoing?
        behaviour_ongoing.eql?(GenericYesNo::NO.to_s)
      end

      def persist!
        super(
          behaviour_description: behaviour_description,
          behaviour_start: behaviour_start,
          behaviour_ongoing: GenericYesNo.new(behaviour_ongoing),
          behaviour_stop: behaviour_stop
        )
      end
    end
  end
end
