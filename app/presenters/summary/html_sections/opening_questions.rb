module Summary
  module HtmlSections
    class OpeningQuestions < Sections::BaseSectionPresenter
      def name
        :opening_questions
      end

      def show_header?
        false
      end

      def answers
        [
          Answer.new(:consent_order_application, c100.consent_order,
                     change_path: edit_steps_opening_consent_order_path),
          FileAnswer.new(:consent_order_upload,
            Uploader.get_file(
                          collection_ref: c100.files_collection_ref,
                          document_key: :draft_consent_order).try(:name),
                     change_path: edit_steps_opening_consent_order_upload_path),
          Answer.new(:child_protection_cases, c100.child_protection_cases,
                     change_path: edit_steps_opening_child_protection_cases_path),
        ].select(&:show?)
      end
    end
  end
end
