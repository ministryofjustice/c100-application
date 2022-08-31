module Summary
  module JsonSections
    class Solicitor
      attr_reader :c100_application
      attr_reader :section_hash

      alias_attribute :c100, :c100_application

      def initialize(c100_application)
        @c100_application = c100_application
        @section_hash = solicitor
      end

      def solicitor
        c100_solicitor = c100_application.solicitor
        {name: c100_solicitor.full_name,
         address: map_address_data(c100_solicitor.address_data),
         contactDX: c100_solicitor.dx_number,
         contactEmailAddress: c100_solicitor.email,
         reference: c100_solicitor.reference,
         ID: c100_solicitor.id,
         organisationID: nil,
         organisationName: c100_solicitor.firm_name}
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
