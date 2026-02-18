def base_page
  @base_page ||= BasePage.new
end

def home_page
  @home_page ||= HomePage.new
end

def what_you_need_page
  @what_you_need_page ||= WhatYouNeedPage.new
end

def consent_order_page
  @consent_order_page ||= ConsentOrderPage.new
end

def upload_consent_order_page
  @upload_consent_order_page ||= UploadConsentOrderPage.new
end

def child_protection_case_page
  @child_protection_case_page ||= ChildProtectionCasePage.new
end

def miam_page
  @miam_page ||= MiamPage.new
end

def safety_concern_page
  @safety_concern_page ||= SafetyConcernPage.new
end

def children_names_page
  @children_names_page ||= ChildrenNamesPage.new
end

def applicant_names_page
  @applicant_names_page ||= ApplicantNamesPage.new
end

def applicant_privacy_known_page
  @applicant_privacy_known_page ||= ApplicantPrivacyKnownPage.new
end

def applicant_privacy_preferences_page
  @applicant_privacy_preferences_page ||= ApplicantPrivacyPreferencesPage.new
end

def applicant_refuge_page
  @applicant_refuge_page ||= ApplicantRefugePage.new
end

def applicant_personal_details_page
  @applicant_personal_details_page ||= ApplicantPersonalDetailsPage.new
end

def applicant_relationship_page
  @applicant_relationship_page ||= ApplicantRelationshipPage.new
end

def address_lookup_page
  @address_lookup_page ||= AddressLookupPage.new
end

def applicant_address_details_page
  @applicant_address_details_page ||= ApplicantAddressDetailsPage.new
end

def applicant_contact_details_page
  @applicant_contact_details_page ||= ApplicantContactDetailsPage.new
end

def applicant_has_solicitor_page
  @applicant_has_solicitor_page ||= ApplicantHasSolicitorPage.new
end

def solicitor_personal_details_page
  @solicitor_personal_details_page ||= SolicitorPersonalDetailsPage.new
end

def solicitor_address_details_page
  @solicitor_address_details_page ||= SolicitorAddressDetailsPage.new
end

def solicitor_contact_details_page
  @solicitor_contact_details_page ||= SolicitorContactDetailsPage.new
end
