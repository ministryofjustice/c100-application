module Steps
  module Children
    class PersonalDetailsForm < BaseForm
      attribute :gender, GenderAttribute
      attribute :dob, MultiParamDate
      attribute :dob_unknown, Boolean
      attribute :dob_estimate, MultiParamDate

      validates_inclusion_of :gender, in: Gender.values

      validates_presence_of :input_dob, unless: :dob_unknown?
      validates_presence_of :dob, unless: :date_entered?
      validates :dob, sensible_date: true, unless: :dob_unknown?
      validates :input_dob, date: true, unless: :dob_unknown?
      validates_presence_of :input_dob_estimate, if: :dob_unknown?
      validates_presence_of :dob_estimate, unless: :date_estimate_entered?
      validates :dob_estimate, sensible_date: true, if: :dob_unknown?
      validates :input_dob_estimate, date: true, if: :dob_unknown?
      validates :input_dob, blank_date_input: true, if: :dob_unknown?
      validate :validate_dob_under_18, unless: :dob_unknown?
      validate :validate_dob_estimate_under_18, if: :dob_unknown?
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

      def date_entered?
        return false if input_dob.nil?

        set_values = input_dob.values_at(1, 2, 3)
        return false if set_values.all?(&:zero?) && !dob_unknown?

        true
      end

      def date_estimate_entered?
        return false if input_dob_estimate.nil?

        set_values = input_dob_estimate.values_at(1, 2, 3)
        return false if set_values.all?(&:zero?) && dob_unknown?

        true
      end

      def validate_dob_under_18
        return if dob.nil?

        errors.add(:dob, :under_18) unless dob > 18.years.ago
      end

      def validate_dob_estimate_under_18
        return if dob_estimate.nil?

        errors.add(:dob_estimate, :under_18) unless dob_estimate > 18.years.ago
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
