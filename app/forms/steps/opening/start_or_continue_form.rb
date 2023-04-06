module Steps
  module Opening
    class StartOrContinueForm < BaseForm
      attribute :start_or_continue, StrippedString
      attribute :children_postcode, StrippedString
      attribute :is_legal_representative, Boolean

      validates :start_or_continue, presence: true
      validates :children_postcode, presence: true, full_uk_postcode: true,
        if: -> { start_or_continue == ApplicationIntent::NEW }

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        c100_application.update(
          children_postcode: children_postcode,
          start_or_continue: start_or_continue,
          is_legal_representative: convertToBoolean(is_legal_representative)
        )
      end

      def convertToBoolean(value)
        (value == true || value == 't') ? 'yes' : 'no'
      end
    end
  end
end
