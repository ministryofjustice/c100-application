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
          FreeTextAnswer.new(:miam_certificate, maim_certificate_answer),
          Separator.new(:hmcts_instructions),
        ].select(&:show?)
      end

      private

      def maim_certificate_answer
        c100.documents(:miam_certificate).any? &&
          I18n.t('check_answers.miam_certificate.answer')
      end
    end
  end
end
