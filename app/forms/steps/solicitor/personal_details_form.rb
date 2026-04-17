module Steps
  module Solicitor
    class PersonalDetailsForm < BaseForm
      include HasOneAssociationForm

      has_one_association :solicitor

      attribute :full_name, :stripped_string
      attribute :firm_name, :stripped_string
      attribute :reference, :stripped_string

      validates_presence_of :full_name, :firm_name

      validates :full_name, sensible_name: true

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        record_to_persist.update(
          attributes_map
        )
      end
    end
  end
end
