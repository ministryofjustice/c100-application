module Steps
  module Opening
    class ContinueApplicationForm < BaseForm
      attribute :platform, StrippedString

      # validates_inclusion_of :platform, in: ApplicationPlatform.values.map(&:to_s)
      validates :platform, presence: true

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        c100_application.update(
          platform:
        )
      end
    end
  end
end
