module Summary
  module HtmlSections
    class AttendingCourt < Sections::BaseSectionPresenter
      def name
        :attending_court
      end

      def answers
        [
          language_assistance,
          litigation_capacity,
          intermediary,
          special_assistance,
          special_arrangements,
        ].flatten.select(&:show?)
      end

      private

      def language_assistance
        AnswersGroup.new(
          :language_help,
          [
            Answer.new(:language_help, c100.language_help),
            FreeTextAnswer.new(:language_help_details, c100.language_help_details),
          ],
          change_path: edit_steps_application_language_path
        )
      end

      def litigation_capacity
        [
          Answer.new(
            :reduced_litigation_capacity,
            c100.reduced_litigation_capacity,
            change_path: edit_steps_application_litigation_capacity_path
          ),
          AnswersGroup.new(
            :litigation_capacity,
            [
              FreeTextAnswer.new(:participation_capacity_details, c100.participation_capacity_details),
              FreeTextAnswer.new(:participation_other_factors_details, c100.participation_other_factors_details),
              FreeTextAnswer.new(:participation_referral_or_assessment_details, c100.participation_referral_or_assessment_details),
            ],
            change_path: edit_steps_application_litigation_capacity_details_path
          )
        ]
      end

      def intermediary
        AnswersGroup.new(
          :intermediary,
          [
            Answer.new(:intermediary_help, c100.intermediary_help),
            FreeTextAnswer.new(:intermediary_help_details, c100.intermediary_help_details),
          ],
          change_path: edit_steps_application_intermediary_path
        )
      end

      def special_assistance
        AnswersGroup.new(
          :special_assistance,
          [
            Answer.new(:special_assistance, c100.special_assistance),
            FreeTextAnswer.new(:special_assistance_details, c100.special_assistance_details),
          ],
          change_path: edit_steps_application_special_assistance_path
        )
      end

      def special_arrangements
        AnswersGroup.new(
          :special_arrangements,
          [
            Answer.new(:special_arrangements, c100.special_arrangements),
            FreeTextAnswer.new(:special_arrangements_details, c100.special_arrangements_details),
          ],
          change_path: edit_steps_application_special_arrangements_path
        )
      end
    end
  end
end
