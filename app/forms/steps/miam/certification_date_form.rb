module Steps
  module Miam
    class CertificationDateForm < BaseForm
      attribute :miam_certification_date, MultiParamDate

      validates_presence_of :input_miam_certification_date
      validates_presence_of :miam_certification_date, unless: :date_entered?
      validates :miam_certification_date, sensible_date: true
      validates :input_miam_certification_date, date: true

      attr_accessor :input_miam_certification_date

      def initialize(args)
        super(**args)
        self.input_miam_certification_date = args[:miam_certification_date]
      end

      private

      def date_entered?
        return false if input_miam_certification_date.nil?

        set_values = input_miam_certification_date.values_at(1, 2, 3)
        return false if set_values.all?(&:zero?)

        true
      end

      def persist!
        raise C100ApplicationNotFound unless c100_application
        c100_application.update(
          miam_certification_date: miam_certification_date
        )
      end
    end
  end
end
