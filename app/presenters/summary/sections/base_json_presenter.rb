module Summary
  module Sections
    class BaseJsonPresenter
      def yes_no(value)
        return 'No' if value == false
        'Yes' if value == true
      end

      def map_address_data(address_data)
        {
          County: nil,
          Country: address_data["country"],
          PostCode: address_data["postcode"],
          PostTown: address_data["town"],
          AddressLine1: address_data["address_line_1"],
          AddressLine2: address_data["address_line_2"],
          AddressLine3: address_data["address_line_3"]
        }
      end
    end
  end
end
