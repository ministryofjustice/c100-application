module Steps
  module Applicant
    class PersonalDetailsForm < BaseForm
      attribute :has_previous_name, YesNo
      attribute :previous_name, StrippedString
      attribute :gender, GenderAttribute
      attribute :dob, MultiParamDate
      attribute :birthplace, StrippedString

      validates_inclusion_of :has_previous_name, in: GenericYesNo.values
      validates_presence_of  :previous_name, if: -> { has_previous_name&.yes? }
      validates_inclusion_of :gender, in: Gender.values
      validates_presence_of :input_dob, :birthplace
      validates_presence_of :dob, unless: :date_entered?
      validates :dob, sensible_date: true
      validates :input_dob, date: true
      validates :previous_name, sensible_name: true, if: -> { has_previous_name&.yes? }

      attr_accessor :input_dob

      def initialize(args)
        super(**args)
        self.input_dob = args[:dob]
      end

      private

      def date_entered?
        return false if input_dob.nil?

        set_values = input_dob.values_at(1, 2, 3)
        return false if set_values.all?(&:zero?)

        true
      end

      def persist!
        raise C100ApplicationNotFound unless c100_application

        applicant = c100_application.applicants.find_or_initialize_by(id: record_id)
        applicant.update(
          attributes_map
        )
      end
    end
  end
end
