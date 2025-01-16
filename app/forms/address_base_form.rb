class AddressBaseForm < BaseForm
  attribute :address_unknown, Boolean, default: false
  attribute :address_line_1, StrippedString
  attribute :address_line_2, StrippedString
  attribute :address_line_3, StrippedString
  attribute :town, StrippedString
  attribute :country, StrippedString
  attribute :postcode, StrippedString

  validates_presence_of :address_line_1, unless: :address_unknown?
  validates_presence_of :town, unless: :address_unknown?
  validates :postcode, full_uk_postcode: true, unless: :address_unknown?
  validates :address_line_1, :address_line_2, :address_line_3, :town, :country, length: { maximum: 35 }

  private

  def address_values
    return {
      address_data: {},
      address_unknown:,
    } if address_unknown?

    {
      address_data: {
        address_line_1:,
        address_line_2:,
        address_line_3:,
        town:,
        country:,
        postcode:,
      },
      address_unknown:,
    }
  end
end
