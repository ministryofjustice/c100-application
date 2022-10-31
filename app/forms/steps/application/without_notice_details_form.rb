module Steps
  module Application
    class WithoutNoticeDetailsForm < BaseForm
      attribute :without_notice_details, String
      attribute :without_notice_frustrate, YesNo
      attribute :without_notice_frustrate_details, String
      attribute :without_notice_impossible, YesNo
      attribute :without_notice_impossible_details, String

      validates_presence_of  :without_notice_details

      validates_inclusion_of :without_notice_frustrate,  in: GenericYesNo.values
      validates_inclusion_of :without_notice_impossible, in: GenericYesNo.values

      validates_presence_of  :without_notice_frustrate_details,  if: -> { without_notice_frustrate&.yes? }
      validates_presence_of  :without_notice_impossible_details, if: -> { without_notice_impossible&.yes? }

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        c100_application.update(
          without_notice_details: without_notice_details,
          without_notice_frustrate: without_notice_frustrate,
          without_notice_frustrate_details: (without_notice_frustrate_details if without_notice_frustrate.yes?),
          without_notice_impossible: without_notice_impossible,
          without_notice_impossible_details: (without_notice_impossible_details if without_notice_impossible.yes?)
        )
      end
    end
  end
end
