module Summary
  module Sections
    class MediatorCertification < BaseSectionPresenter
      def name
        :mediator_certification
      end

      def show_header?
        false
      end

      def answers
        return [
          Separator.not_applicable
        ] unless c100.miam_certification.eql?(GenericYesNo::YES.to_s)

        [
          Separator.new(:hmcts_instructions),
        ].select(&:show?)
      end
    end
  end
end
