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
        if exemptions.empty? && c100.documents(:exemption).none?
          [Separator.not_applicable]
        elsif c100_application.exemption_reasons.nil?
          [
            Partial.new(:miam_exemptions, exemptions)
          ]
        else
          [
            Partial.new(:miam_exemptions, exemptions),
            Partial.new(:exemption_details, c100_application.exemption_details),
            Partial.new(:exemption_reasons, c100_application.exemption_reasons),
            Answer.new(:attach_evidence, c100_application.attach_evidence),
            FreeTextAnswer.new(:exemption, exemption_document_answer),
          ]
        end
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
