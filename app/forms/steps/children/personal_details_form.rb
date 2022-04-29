module Steps
  module Children
    class PersonalDetailsForm < BaseForm
      attribute :gender, GenderAttribute
      attribute :dob, MultiParamDate
      attribute :dob_unknown, Boolean
      attribute :dob_estimate, MultiParamDate

      validates_presence_of :dob, unless: :dob_unknown?
      validates_inclusion_of :gender, in: Gender.values
      validates_absence_of :dob, if: :dob_unknown?, message: 'Please untick "unknown date of birth" if date of birth is known.'
      validates_absence_of :dob, if: :dob_estimate, message: 'Please remove "estimate date of birth" if date of birth is known.'

      validates :dob, sensible_date: true, unless: :dob_unknown?
      validates :dob_estimate, sensible_date: true, if: :dob_unknown?

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

        child = c100_application.children.find_or_initialize_by(id: record_id)
        child.update(
          attributes_map
        )
      end
    end
  end
end
