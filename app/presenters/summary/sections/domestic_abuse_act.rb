module Summary
  module Sections
    class DomesticAbuseAct < BaseSectionPresenter
      def name
        :domestic_abuse_act
      end

      def show?
        true
      end

      def to_partial_path
        'steps/completion/shared/domestic_abuse_act'
      end

    end
  end
end
