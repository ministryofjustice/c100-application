module PersonWithPrivacy
  extend ActiveSupport::Concern

  def email_private?
    contact_details_private.include? ContactDetails::EMAIL.to_s
  end

  def home_phone_private?
    contact_details_private.include? ContactDetails::HOME_PHONE.to_s
  end

  def mobile_private?
    contact_details_private.include? ContactDetails::MOBILE.to_s
  end

  def address_private?
    return false unless contact_details_private

    contact_details_private.include? ContactDetails::ADDRESS.to_s
  end
end
