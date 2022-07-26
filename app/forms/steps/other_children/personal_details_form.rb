module Steps
  module OtherChildren
    class PersonalDetailsForm < BaseForm
      attribute :gender, GenderAttribute
      attribute :dob, MultiParamDate
      attribute :dob_unknown, Boolean
      attribute :dob_estimate, MultiParamDate

      validates_inclusion_of :gender, in: Gender.values

      validates_presence_of :dob, unless: :dob_unknown?
      validates :dob, sensible_date: true, unless: :dob_unknown?
      validates :input_dob, date: true, unless: :dob_unknown?
      validates :dob_estimate, sensible_date: true, if: :dob_unknown?
      validates :input_dob_estimate, date: true, if: :dob_unknown?
      validates :input_dob, blank_date_input: true, if: :dob_unknown?

      # We have to save the date inputes to validate later
      # because MultiParamDate will nil
      # any invalid input date, and there is no clean way
      # to validate an invalid date on entry
      attr_accessor :input_dob, :input_dob_estimate

      def initialize(args)
        super(**args)
        self.dob_estimate = nil unless dob_unknown?
        self.input_dob = args[:dob]
        self.input_dob_estimate = args[:dob_estimate]
      end

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        child = c100_application.other_children.find_or_initialize_by(id: record_id)
        child.update(
          attributes_map
        )
      end
    end
  end
end
