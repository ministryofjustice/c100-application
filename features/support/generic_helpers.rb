
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

def application_type_page
  @application_type_page ||= ApplicationTypePage.new
end

def no_court_page
  @no_court_page ||= NoCourtPage.new
end

def error_page
  @error_page ||= ErrorCPage.new
end

def something_wrong_page
  @something_wrong_page ||= SomethingWrongPage.new
end

def button_click(value)
  begin
    click_button(value)
  rescue
    click_link(value)
  end
end

def timeout(value)
  travel 61.minutes do
    button_click(value)
  end
end

def api_stubbing
  WebMock.enable!
  WebMock.allow_net_connect!
  WebMock::API.stub_request(:get, "https://www.find-court-tribunal.service.gov.uk/v2/proxy/search/postcode/TQ121XX/serviceArea/childcare-arrangements").
    to_return(status: 200, body: "{}", headers: {})
  WebMock::API.stub_request(:get, "https://www.find-court-tribunal.service.gov.uk/health").
    to_return(status: 200, body: "{\"mapit-api\":{\"status\":\"UP\"}}", headers: {})
end