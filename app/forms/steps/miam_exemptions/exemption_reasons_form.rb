module Steps
  module MiamExemptions
    class ExemptionReasonsForm < BaseForm
      attribute :exemption_reasons, String
      attribute :attach_evidence, YesNo

      validates_inclusion_of :attach_evidence, in: GenericYesNo.values

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        c100_application.update(
          exemption_reasons:,
          attach_evidence:
        )
      end
    end
  end
end
