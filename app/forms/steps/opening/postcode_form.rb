module Steps
  module Opening
    class PostcodeForm < BaseForm
      attribute :children_postcode, StrippedString
      attribute :start_or_continue, StrippedString
      attribute :is_legal_representative, Boolean
      validates :children_postcode, presence: true, full_uk_postcode: true

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        c100_application.update(
          children_postcode: children_postcode,
        )
      end
    end
  end
end
