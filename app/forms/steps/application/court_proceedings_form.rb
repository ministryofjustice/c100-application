module Steps
  module Application
    class CourtProceedingsForm < BaseForm
      include HasOneAssociationForm

      has_one_association :court_proceeding

      attribute :children_names, :string
      attribute :court_name, :stripped_string
      attribute :case_number, :stripped_string
      attribute :proceedings_date, :string
      attribute :cafcass_details, :string
      attribute :order_types, :string
      attribute :previous_details, :string

      validates_presence_of :children_names,
                            :court_name,
                            :order_types

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
