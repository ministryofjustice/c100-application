module Summary
  module HtmlSections
    class Submission < Sections::BaseSectionPresenter
      def name
        :submission
      end

      def answers
        [
          AnswersGroup.new(
            :submission_type,
            [
              FreeTextAnswer.new(:submission_receipt_email, c100.receipt_email, show: true),
            ],
            change_path: edit_steps_application_submission_path
          )
        ].select(&:show?)
      end
    end
  end
end
