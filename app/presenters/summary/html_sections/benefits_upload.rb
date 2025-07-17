module Summary
  module HtmlSections
    class BenefitsUpload < Sections::BaseSectionPresenter
      def name
        :benefits_upload
      end

      def answers
        files = Uploader.get_file(
          collection_ref: c100.files_collection_ref,
          document_key: :benefits_evidence
        )
        return [] if files.empty?

        file_names = files.map(&:name)

        [
          FileAnswer.new(
            :benefits_upload,
            file_names,
            change_path: edit_steps_application_benefits_upload_path
          )
        ].select(&:show?)
      end
    end
  end
end
