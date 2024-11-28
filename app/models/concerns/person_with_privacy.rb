module PersonWithPrivacy
  extend ActiveSupport::Concern

  def email_private?
    in_refuge? || contact_details_private.include?(ContactDetails::EMAIL.to_s)
  end

  def home_phone_private?
    in_refuge? || contact_details_private.include?(ContactDetails::HOME_PHONE.to_s)
  end

  def mobile_private?
    in_refuge? || contact_details_private.include?(ContactDetails::MOBILE.to_s)
  end

  def address_private?
    return false unless contact_details_private

    in_refuge? || contact_details_private.include?(ContactDetails::ADDRESS.to_s)
  end

  private

  def in_refuge?
    refuge == 'yes'
  end
end
