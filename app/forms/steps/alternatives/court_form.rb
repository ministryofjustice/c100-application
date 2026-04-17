module Steps
  module Alternatives
    class CourtForm < BaseForm
      attribute :court_acknowledgement, :boolean

      validates_presence_of :court_acknowledgement

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        c100_application.update(
          court_acknowledgement:
        )
      end
    end
  end
end
