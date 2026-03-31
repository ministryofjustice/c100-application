module Steps
  module AbuseConcerns
    class DetailsForm < BaseAbuseForm
      attribute :behaviour_description, :string
      attribute :behaviour_start, :string
      attribute :behaviour_ongoing, :yes_no
      attribute :behaviour_stop, :string
      attribute :asked_for_help, :yes_no
      attribute :help_party, :string
      attribute :help_provided, :yes_no
      attribute :help_description, :string

      validates_presence_of :behaviour_description, :behaviour_start,
                            :behaviour_ongoing, :asked_for_help,
                            message: proc { |_error, attributes| err_msg(attributes) }
      validates_presence_of :behaviour_stop,
                            message: proc { |_error, attributes| err_msg(attributes) },
                            if: -> { behaviour_ongoing == GenericYesNo.new(:no) }
      validates_presence_of :help_party,
                            message: proc { |_error, attributes| err_msg(attributes) },
                            if: -> { asked_for_help == GenericYesNo.new(:yes) }
      validates_presence_of :help_provided,
                            message: proc { |_error, attributes| err_msg(attributes) },
                            if: -> { asked_for_help == GenericYesNo.new(:yes) }
      validates_presence_of :help_description,
                            message: proc { |_error, attributes| err_msg(attributes) },
                            if: lambda {
                                  asked_for_help == GenericYesNo.new(:yes) &&
                                    help_provided == GenericYesNo.new(:yes)
                                }

      def self.err_msg(attributes)
        I18n.translate!("steps.abuse_concerns.details.edit.errors.#{
          attributes[:attribute].parameterize.underscore}")
      end

      private

      def persist!
        super(
          subject:,
          kind:,
          behaviour_description:,
          behaviour_start:,
          behaviour_ongoing:,
          behaviour_stop: (behaviour_stop if behaviour_ongoing.no?),
          asked_for_help:,
          help_party: (help_party if asked_for_help.yes?),
          help_provided: (help_provided if asked_for_help.yes?),
          help_description: (help_description if asked_for_help.yes?)
        )
      end
    end
  end
end
