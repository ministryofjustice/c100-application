module Steps
  module Applicant
    class RefugeForm < BaseForm
      include ActiveModel::Validations::Callbacks

      attribute :refuge, YesNo

      validates_inclusion_of :refuge, in: GenericYesNo.values

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        applicant = c100_application.applicants.find_or_initialize_by(id: record_id)

        attrs = attributes_map

        if refuge&.yes?
          attrs[:are_contact_details_private] = GenericYesNo::YES.to_s
          attrs[:contact_details_private] =
            [
              ContactDetails::ADDRESS.to_s,
              ContactDetails::EMAIL.to_s,
              ContactDetails::PHONE_NUMBER.to_s
            ]
        end

        applicant.update(attrs)
      end
    end
  end
end
