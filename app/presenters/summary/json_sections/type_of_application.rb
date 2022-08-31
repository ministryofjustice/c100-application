module Summary
  module JsonSections
    class TypeOfApplication
      attr_reader :c100_application
      attr_reader :section_hash

      alias_attribute :c100, :c100_application

      def initialize(c100_application)
        @c100_application = c100_application
        @section_hash = type_of_application
      end

      def type_of_application
        { orderAppliedFor: order_type_answers(c100_application.children),
        typeOfChildArrangementsOrder: order_arrangements,
        # natureOfOrder: "egb",
        consentOrder: c100_application.consent_order,
        applicationPermissionRequired: c100_application.permission_sought,
        applicationPermissionRequiredReason: c100_application.permission_details,
        applicationDetails: c100_application.application_details }
      end

      def order_type_answers(children)
        orders = []
        children.each do |child|
          orders << order_types(child).map do |order_value|
            I18n.t(".dictionary.PETITION_ORDER_TYPES.#{order_value}")
          end
        end
        orders.flatten.join(', ')
      end

      def order_arrangements
        orders = []
        c100_application.orders.each do |order|
          orders << I18n.t(".dictionary.PETITION_ORDERS.#{order}")
        end
        orders.flatten.join(', ')
      end

      def order_types(child)
        child.child_order.orders.to_a.map do |o|
          PetitionOrder.type_for(o)
        end.uniq
      end
    end
  end
end
