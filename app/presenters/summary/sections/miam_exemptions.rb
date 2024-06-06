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
            Partial.new(:exemption_details, exemption_details_answer),
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

      def exemption_details_answer
        return c100_application.exemption_details if c100_application.exemption_details.present?
        I18n.t('check_answers.exemption_details.absence_answer')
      end

      def exemptions
        @_exemptions ||= MiamExemptionsPresenter.new(
          c100.miam_exemption
        ).exemptions
      end
    end
  end
end
