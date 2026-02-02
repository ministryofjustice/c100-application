module Steps
  module Application
    class ExistingCourtOrderController < Steps::ApplicationStepController
      def edit
        @form_object = ExistingCourtOrderForm.new(
          c100_application: current_c100_application,
          existing_court_order: current_c100_application.existing_court_order,
          court_order_case_number: current_c100_application.court_order_case_number,
          court_order_expiry_date: current_c100_application.court_order_expiry_date,
        )
      end

      def update
        update_and_advance(ExistingCourtOrderForm)
      end
    end
  end
end
