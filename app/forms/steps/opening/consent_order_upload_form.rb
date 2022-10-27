module Steps
  module Opening
    class ConsentOrderUploadForm < BaseForm
      # attribute :consent_order_file
      # validates :consent_order_file, presence: true

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        # c100_application.update(
        #   consent_order_file: consent_order_file,
        # )
        true
      end
    end
  end
end
