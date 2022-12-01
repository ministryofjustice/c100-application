
def base_page
  @base_page ||= BasePage.new
end

def home_page
  @home_page ||= HomePage.new
end

def postcode_page
  @postcode_page ||= PostcodePage.new
end

def signin_page
  @signin_page ||= SignInPage.new
end
