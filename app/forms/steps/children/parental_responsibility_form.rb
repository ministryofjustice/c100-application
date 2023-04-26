module Steps
  module Children
    class ParentalResponsibilityForm < BaseForm
      attribute :parental_responsibility, String

      validates_presence_of :parental_responsibility

      private

      def persist!
        raise C100ApplicationNotFound unless c100_application

        child = c100_application.children.find_by!(id: record_id)
        child.update(
          **attributes_map
        )
      end
    end
  end
end
