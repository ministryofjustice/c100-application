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

def cookie_management_page
  @cookie_management_page ||= CookieManagementPage.new
end

def stub_courtfinder_api
  stub_resp = {
    "slug"=>"childcare-arrangements",
    "name"=>"Childcare arrangements if you separate from your partner",
    "onlineText"=>nil,
    "onlineUrl"=>"https://apply-to-court-about-child-arrangements.service.justice.gov.uk/",
    "courts"=>[{"name"=>"Coventry Combined Court Centre",
                "slug"=>"coventry-combined-court-centre",
                "distance"=>10.6,
                "areasOfLawSpoe"=>["Children"]}]
  }
  court_lookup_resp = {"name"=>"Coventry Combined Court Centre", "slug"=>"coventry-combined-court-centre", "info"=>"<p><a href=https://www.gov.uk/government/news/scammers-using-hmcts-telephone-numbers>Scammers are mimicking genuine HMCTS phone numbers and email addresses</a>. They may demand payment and claim to be from HMRC or enforcement. If you're unsure, do not pay anything and report the scam to <a href=https://www.actionfraud.police.uk/>Action Fraud</a>.</p>", "open"=>true, "directions"=>nil, "image_file"=>"coventry_combined_court_centre.jpg", "lat"=>52.4055836530515, "lon"=>-1.50643963844351, "urgent_message"=>"", "crown_location_code"=>417, "family_location_code"=>180, "magistrates_location_code"=>nil, "tribunal_location_code"=>nil, "areas_of_law"=>[{"name"=>"Adoption", "external_link"=>"https://www.gov.uk/child-adoption", "display_url"=>nil, "external_link_desc"=>"Information about adopting a child", "display_name"=>nil, "display_external_link"=>"https://www.gov.uk/child-adoption/applying-for-an-adoption-court-order"}, {"name"=>"Bankruptcy", "external_link"=>"https://www.gov.uk/apply-for-bankruptcy", "display_url"=>nil, "external_link_desc"=>"Information about applying for bankruptcy", "display_name"=>nil, "display_external_link"=>"https://www.gov.uk/bankruptcy"}, {"name"=>"Children", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>"Childcare arrangements if you separate from your partner", "display_external_link"=>"https://www.gov.uk/looking-after-children-divorce"}, {"name"=>"Crime", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>nil, "display_external_link"=>nil}, {"name"=>"Divorce", "external_link"=>"https://www.gov.uk/divorce", "display_url"=>nil, "external_link_desc"=>"Information about getting a divorce", "display_name"=>"Divorce hearings", "display_external_link"=>nil}, {"name"=>"Domestic violence", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>"Domestic abuse", "display_external_link"=>"https://www.gov.uk/injunction-domestic-violence"}, {"name"=>"High Court District Registry", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>"High Court cases – serious or high profile criminal or civil law cases", "display_external_link"=>nil}, {"name"=>"Housing possession", "external_link"=>"https://www.gov.uk/evicting-tenants", "display_url"=>nil, "external_link_desc"=>"Information about evicting tenants", "display_name"=>"Housing", "display_external_link"=>nil}, {"name"=>"Money claims", "external_link"=>"https://www.gov.uk/make-court-claim-for-money", "display_url"=>nil, "external_link_desc"=>"Information about making a court claim for money", "display_name"=>nil, "display_external_link"=>nil}, {"name"=>"Single justice procedure", "external_link"=>"", "display_url"=>nil, "external_link_desc"=>nil, "display_name"=>nil, "display_external_link"=>nil}], "types"=>["Family Court", "County Court", "Crown Court"], "emails"=>[{"address"=>"warwickcrowncourt@justice.gov.uk", "description"=>"Crown court", "explanation"=>nil}, {"address"=>"bailiffs.coventry.countycourt@justice.gov.uk", "description"=>"Enforcement", "explanation"=>nil}, {"address"=>"civilenquiries.coventry.countycourt@justice.gov.uk", "description"=>"County court", "explanation"=>"Civil enquiries"}, {"address"=>"Civilhearings.coventry.countycourt@justice.gov.uk", "description"=>"Listing", "explanation"=>nil}, {"address"=>"coventry.breathingspace@justice.gov.uk", "description"=>"Breathing space enquiries", "explanation"=>""}, {"address"=>"divorce.coventry.countycourt@justice.gov.uk", "description"=>"Family court", "explanation"=>nil}, {"address"=>"children.coventry.countycourt@justice.gov.uk", "description"=>"Family public law (children in care)", "explanation"=>"Paper process"}, {"address"=>"contactfpl@justice.gov.uk", "description"=>"Family public law (children in care)", "explanation"=>"Digital process for case numbers starting with C5"}, {"address"=>"coventryprivatelawapplications@justice.gov.uk", "description"=>"Applications", "explanation"=>"C100 applications"}], "contacts"=>[{"number"=>"0300 332 1000", "description"=>"Enquiries", "explanation"=>"Witness Services enquiries"}, {"number"=>"0300 123 5577", "description"=>"County court", "explanation"=>""}, {"number"=>"0247 653 6322", "description"=>"Counter appointments", "explanation"=>""}, {"number"=>"01926 429 133", "description"=>"Crown court", "explanation"=>""}, {"number"=>"0330 808 4424", "description"=>"Family public law (children in care)", "explanation"=>"Digital process for case numbers starting with C5"}, {"number"=>"01264 347 973", "description"=>"Fax", "explanation"=>""}], "opening_times"=>[{"description"=>"Counter service by appointment only", "hours"=>"Monday to Friday 10am to 2pm", "description_cy"=>nil}, {"description"=>"Telephone enquiries answered", "hours"=>"Monday to Friday 8:30am to 5pm", "description_cy"=>nil}, {"description"=>"Court open", "hours"=>"Monday to Friday 9am to 5pm", "description_cy"=>nil}], "application_updates"=>[], "facilities"=>[{"description"=>"This building has level access to the building entrance, and court room.\r\n ", "name"=>"Disabled access", "order"=>2}, {"description"=>"Assistance dogs are welcome.", "name"=>"Assistance dogs", "order"=>4}, {"description"=>"The building has hearing enhancement facilities available by prior arrangement.  Please contact the Court office by telephone or email if necessary.", "name"=>"Hearing Loop", "order"=>5}, {"description"=>"Refreshments are available via Vending Machine.", "name"=>"Refreshments", "order"=>11}, {"description"=>"4 interview rooms are available on the ground floor", "name"=>"Interview room", "order"=>12}, {"description"=>"This Court has a childrens room facility.", "name"=>"Children's waiting room", "order"=>14}, {"description"=>"Baby changing facilities are available in the disabled toilets on the ground floor\r\n ", "name"=>"Baby changing facility", "order"=>15}, {"description"=>"Court/hearing room video conferencing facilities and prison to court video link facilities are available by prior arrangement.Please contact the Court administration to check availability.\r\n \r\n.\r\n ", "name"=>"Video facilities", "order"=>17}, {"description"=>" \r\nSupport for witnesses is available from the <a href=\"https://www.citizensadvice.org.uk/\" rel=\"nofollow\">Citizens Advice</a> witness service. Support Through Court is available on Mondays to provide assistance.", "name"=>"Witness service", "order"=>19}], "addresses"=>[{"address_lines"=>["140 Much Park Street"], "postcode"=>"CV1 2SN", "town"=>"Coventry", "type"=>"Visit or contact us", "county"=>"Warwickshire", "description"=>nil, "fields_of_law"=>nil}], "gbs"=>"Y260", "dx_number"=>["701580 Coventry 5"], "service_area"=>[], "in_person"=>true, "access_scheme"=>true, "additional_links"=>[{"url"=>"https://www.gov.uk/guidance/debt-respite-breathing-space-scheme-creditors-responsibilities-to-the-court", "description"=>"Breathing Space"}], "common_flag"=>false, "service_centre"=>{"is_a_service_centre"=>false, "intro_paragraph"=>"", "intro_paragraph_cy"=>""}}
  C100App::CourtfinderAPI.any_instance.stub(:court_for).and_return(stub_resp)
  C100App::CourtfinderAPI.any_instance.stub(:court_lookup).and_return(court_lookup_resp)
end