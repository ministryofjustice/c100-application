module Summary
  module Sections
    class MiamExemptions < BaseSectionPresenter
      def name
        :miam_exemptions
      end

      def show_header?
        false
      end

      def answers
        return [
          Separator.not_applicable
        ] if exemptions.empty?

        [
          Partial.new(:miam_exemptions, exemptions),
          FreeTextAnswer.new(:exemption_details, c100_application.exemption_details, default: Separator.not_applicable),
          FreeTextAnswer.new(:exemption_reasons, c100_application.exemption_reasons, default: Separator.not_applicable),
          Answer.new(:attach_evidence, c100_application.attach_evidence),
          FreeTextAnswer.new(:exemption, exemption_document_answer),
        ]
      end

      private

      def exemption_document_answer
        c100.documents(:exemption).any? &&
          I18n.t('check_answers.exemption.answer')
      end

      def exemptions
        @_exemptions ||= MiamExemptionsPresenter.new(
          c100.miam_exemption
        ).exemptions
      end
    end
  end
end
