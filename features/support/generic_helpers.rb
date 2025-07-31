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
