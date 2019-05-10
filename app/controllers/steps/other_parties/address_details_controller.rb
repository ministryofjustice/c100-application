module Steps
  module OtherParties
    class AddressDetailsController < Steps::OtherPartiesStepController
      def edit
        @form_object = AddressDetailsForm.new(
          address: current_record.address,
          address_unknown: current_record.address_unknown,
          address_line_1: current_record.address_line_1,
          address_line_2: current_record.address_line_2,
          town: current_record.town,
          country: current_record.country,
          postcode: current_record.postcode,
          c100_application: current_c100_application,
          record: current_record
        )
      end

      def update
        update_and_advance(
          AddressDetailsForm,
          record: current_record,
          as: :address_details
        )
      end
    end
  end
end
