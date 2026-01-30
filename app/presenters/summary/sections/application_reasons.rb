module Summary
  module Sections
    class ApplicationReasons < BaseSectionPresenter
      def name
        :application_reasons
      end

      def show_header?
        false
      end

      def answers
        [
          Answer.new(:permission_sought, c100.permission_sought, default: :not_required),
          FreeTextAnswer.new(:permission_details, c100.permission_details),
          FreeTextAnswer.new(:application_details, c100.application_details),
          FreeTextAnswer.new(:existing_court_order, c100.existing_court_order),
          FreeTextAnswer.new(:court_order_case_number, c100.court_order_case_number),
          FreeTextAnswer.new(:court_order_expiry_date, c100.court_order_expiry_date),
          Answer.new(:existing_court_order_uploadable, c100.existing_court_order_uploadable),

          FreeTextAnswer.new(:existing_court_order_upload, existing_court_order_document_answer),
        ].select(&:show?)
      end

      private

      def existing_court_order_document_answer
        puts 'c100.existing_court_order_uploadable: ' + c100.existing_court_order_uploadable.to_s
        return I18n.t('check_answers.existing_court_order_upload.absence_answer') if c100.existing_court_order_uploadable == GenericYesNo::NO.to_s

        c100.documents(:existing_court_order).any? &&
          I18n.t('check_answers.existing_court_order_upload.answer')
      end
    end
  end
end
