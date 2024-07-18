module Steps
  module Application
    class SubmissionForm < BaseForm
      attribute :submission_type, String
      attribute :receipt_email, NormalisedEmail

      validates :receipt_email, email: true, allow_blank: true

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        c100_application.update(
          submission_type: SubmissionType::ONLINE.to_s,
          receipt_email:
        )
      end
    end
  end
end
