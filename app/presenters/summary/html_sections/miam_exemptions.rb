module Summary
  module HtmlSections
    class MiamExemptions < Sections::BaseSectionPresenter
      def name
        :miam_exemptions
      end

      # rubocop:disable Metrics/MethodLength
      # rubocop:disable Metrics/AbcSize
      def answers
        [
          MultiAnswer.new(
            :miam_exemptions_domestic,
            selection_for(:domestic),
            change_path: edit_steps_miam_exemptions_domestic_path
          ),
          MultiAnswer.new(
            :miam_exemptions_protection,
            selection_for(:protection),
            change_path: edit_steps_miam_exemptions_protection_path
          ),
          MultiAnswer.new(
            :miam_exemptions_urgency,
            selection_for(:urgency),
            change_path: edit_steps_miam_exemptions_urgency_path
          ),
          MultiAnswer.new(
            :miam_exemptions_adr,
            selection_for(:adr),
            change_path: edit_steps_miam_exemptions_adr_path
          ),
          MultiAnswer.new(
            :miam_exemptions_misc,
            selection_for(:misc),
            change_path: edit_steps_miam_exemptions_misc_path
          ),
          FreeTextAnswer.new(
            :exemption_details, c100.exemption_details,
            change_path: edit_steps_miam_exemptions_exemption_details_path
          ),
          FreeTextAnswer.new(
            :exemption_reasons, c100.exemption_reasons,
            change_path: edit_steps_miam_exemptions_exemption_reasons_path
          ),
          Answer.new(:attach_evidence, c100.attach_evidence,
                     change_path: edit_steps_miam_exemptions_exemption_reasons_path),
          file_answer
        ].select(&:show?)
      end
      # rubocop:enable Metrics/MethodLength
      # rubocop:enable Metrics/AbcSize

      private

      def file_answer
        if c100.attach_evidence == 'yes'
          FileAnswer.new(:exemption,
                         Uploader.get_file(
                           collection_ref: c100.files_collection_ref,
                           document_key: :exemption
                         ).try(:name),
                         change_path: edit_steps_miam_exemptions_exemption_upload_path)
        else
          Answer.new(:exemption, :not_applicable,
                     change_path: edit_steps_miam_exemptions_exemption_upload_path)
        end
      end

      def selection_for(group)
        presenter.selection_for(group, filter: :groups)
      end

      def presenter
        @_presenter ||= MiamExemptionsPresenter.new(c100.miam_exemption)
      end
    end
  end
end
