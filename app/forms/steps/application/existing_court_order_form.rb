module Steps
  module Application
    class ExistingCourtOrderForm < BaseForm
      attribute :existing_court_order, YesNo
      attribute :court_order_case_number, String
      attribute :court_order_expiry_date, MultiParamDate

      validates_inclusion_of :existing_court_order, in: GenericYesNo.values
      validates_presence_of :court_order_expiry_date, if: :date_entered?
      validates :court_order_expiry_date, date: true, if: -> { existing_court_order&.yes? }
      validates :input_court_order_expiry_date, date: true, if: -> { existing_court_order&.yes? }

      attr_accessor :input_court_order_expiry_date

      def initialize(args)
        super(**args)
        self.input_court_order_expiry_date = args[:court_order_expiry_date]
      end

      private

      def date_entered?
        return false unless existing_court_order&.yes?
        return false if input_court_order_expiry_date[1..3].all? { |v| v.is_a?(Numeric) && v.zero? }

        set_values = input_court_order_expiry_date.values_at(1, 2, 3)
        return false if set_values.all?(&:zero?)

        true
      end

      def persist!
        raise C100ApplicationNotFound unless c100_application

        reset_attr = existing_court_order == GenericYesNo::NO

        c100_application.update(
          existing_court_order:,
          court_order_case_number: reset_attr ? nil : court_order_case_number,
          court_order_expiry_date: reset_attr ? nil : court_order_expiry_date,
          existing_court_order_uploadable: reset_attr ? nil : c100_application.existing_court_order_uploadable,
        )
      end
    end
  end
end
