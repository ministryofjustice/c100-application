module Steps
  module Petition
    class OrdersForm < BaseForm
      attribute :orders, Array[String]
      attribute :orders_collection, Array[String]

      validate :at_least_one_order_validation
      validate :at_least_one_prohibited_step, if: lambda {
                                                    selected_options.include?(PetitionOrder::GROUP_PROHIBITED_STEPS.to_s)
                                                  }
      validate :at_least_one_specific_issue, if: lambda {
                                                   selected_options.include?(PetitionOrder::GROUP_SPECIFIC_ISSUES.to_s)
                                                 }

      # Custom setter so we always have both attributes synced, as one attribute is
      # the main categories and the other are subcategories.
      # Needed to make the revealing check boxes work nice with errors, etc.
      #
      def orders_collection=(values)
        super(Array(values) | Array(orders))
      end

      private

      # We filter out `group_xxx` items, as the purpose of these are to present the orders
      # in groups for the user to show/hide them, and are not really an order by itself.
      #
      def valid_options
        clean_options.grep_v(/\Agroup_/)
      end

      def at_least_one_prohibited_step
        prohibited_steps = PetitionOrder::PROHIBITED_STEPS.map(&:to_s)
        return if (selected_options & prohibited_steps).any?
        errors.add(:orders, :missing_prohibited_step)
      end

      def at_least_one_specific_issue
        specific_issues = PetitionOrder::SPECIFIC_ISSUES.map(&:to_s)
        return if (selected_options & specific_issues).any?
        errors.add(:orders, :missing_specific_issue)
      end

      def selected_options
        (orders_collection + orders) & PetitionOrder.string_values
      end

      def at_least_one_order_validation
        errors.add(:orders, :blank) unless valid_options.any?
      end

      def clean_options
        cleaned = selected_options
        cleaned -= PetitionOrder::PROHIBITED_STEPS.map(&:to_s) \
          if selected_options.exclude?(PetitionOrder::GROUP_PROHIBITED_STEPS.to_s)
        cleaned -= PetitionOrder::SPECIFIC_ISSUES.map(&:to_s) \
          if selected_options.exclude?(PetitionOrder::GROUP_SPECIFIC_ISSUES.to_s)
        cleaned
      end

      def persist!
        raise C100ApplicationNotFound unless c100_application

        c100_application.update(
          orders: clean_options
        )
      end
    end
  end
end
