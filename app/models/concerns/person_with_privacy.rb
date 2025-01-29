module PersonWithPrivacy
  extend ActiveSupport::Concern

  def email_private?
    in_refuge? || contact_details_private.include?(ContactDetails::EMAIL.to_s)
  end

  def phone_number_private?
    in_refuge? || contact_details_private.include?(ContactDetails::PHONE_NUMBER.to_s)
  end

  def address_private?
    return false unless contact_details_private

    in_refuge? || contact_details_private.include?(ContactDetails::ADDRESS.to_s)
  end

  private

  def in_refuge?
    refuge == GenericYesNo::YES.to_s
  end
end
