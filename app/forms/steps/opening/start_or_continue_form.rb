module Steps
  module Opening
    class StartOrContinueForm < BaseForm
      # attribute :start_or_continue, StrippedString
      # attribute :children_postcode, StrippedString
      # attribute :children_postcode_continue, StrippedString
      # attribute :is_legal_representative, Boolean
      #
      # validates_inclusion_of :start_or_continue, in: ApplicationIntent.values.map(&:to_s)
      # validates :start_or_continue, presence: true
      # validates :children_postcode, presence: true, full_uk_postcode: true,
      #   if: -> { new? }
      # validates :children_postcode_continue, presence: true, full_uk_postcode: true,
      #   if: -> { continue? }
      #
      # private
      #
      # def persist!
      #   raise C100ApplicationNotFound unless c100_application
      #
      #   c100_application.update(
      #     children_postcode: new? ? children_postcode : children_postcode_continue,
      #     start_or_continue:,
      #     is_legal_representative: convert_to_boolean(is_legal_representative)
      #   )
      # end
      #
      # def new?
      #   start_or_continue == ApplicationIntent::NEW.to_s
      # end
      #
      # def continue?
      #   start_or_continue == ApplicationIntent::CONTINUE.to_s
      # end
      #
      # def convert_to_boolean(value)
      #   [true, 't'].include?(value) ? 'yes' : 'no'
      # end
    end
  end
end
