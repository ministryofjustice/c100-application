module Summary
  module Sections
    class ProcessingDetails < BaseSectionPresenter
      def name
        :processing_details
      end

      def answers
        [
          FreeTextAnswer.new(:court_name_and_code, court_name_and_code),
          FreeTextAnswer.new(:completion_date, completion_date),
        ].select(&:show?)
      end

      private

      # TODO: for a while some applications will lack the `family_location_code`
      # or the `completed_at` date, so we need to cover these scenarios.
      # After 1 month approximately, this code can be simplified.

      def court_name_and_code
        [court.family_location_code, court.name].compact.join(' - ')
      end

      def completion_date
        I18n.l(c100.completed_at.in_time_zone("London").to_datetime, format: :date_and_time) if c100.completed_at
      end

      def court
        @_court ||= c100.court
      end
    end
  end
end
