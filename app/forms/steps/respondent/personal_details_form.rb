module Steps
  module Respondent
    class PersonalDetailsForm < BaseForm
      attribute :has_previous_name, YesNoUnknown
      attribute :previous_name, StrippedString
      attribute :gender, GenderAttribute
      attribute :dob, MultiParamDate
      attribute :dob_unknown, Boolean
      attribute :dob_estimate, MultiParamDate
      attribute :birthplace, StrippedString
      attribute :birthplace_unknown, Boolean

      validates_inclusion_of :has_previous_name, in: GenericYesNoUnknown.values
      validates_presence_of  :previous_name, if: -> { has_previous_name&.yes? }

      validates_inclusion_of :gender, in: Gender.values

      validates_presence_of  :dob, unless: :dob_unknown?
      validates :dob, sensible_date: true, unless: :dob_unknown?
      validates :dob_estimate, sensible_date: true, if: :dob_unknown?

      validates_presence_of :birthplace, unless: :birthplace_unknown?

      # We have to save the date inputes to validate later
      # because MultiParamDate will nil
      # any invalid input date, and there is no clean way
      # to validate an invalid date on entry
      validate :no_date_errors
      attr_accessor :input_dob, :input_dob_estimate

      def initialize(args)
        super(**args)
        self.input_dob = args[:dob]
        self.input_dob_estimate = args[:dob_estimate]
      end

      private

      def no_date_errors
        [[:dob, input_dob],
         [:dob_estimate, input_dob_estimate]].each do |input|
          validate_date(input[0], input[1])
        end
      end

      def persist!
        raise C100ApplicationNotFound unless c100_application

        respondent = c100_application.respondents.find_or_initialize_by(id: record_id)
        respondent.update(
          attributes_map
        )
      end
    end
  end
end
