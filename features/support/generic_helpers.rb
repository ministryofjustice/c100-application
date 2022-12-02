
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



def continue_button_click
  begin
    click_button('Continue')
  rescue
    click_link('Continue')
  end
end

def back_button_click
  click_link('Back')
end

def timeout_continue
  travel 61.minutes do
    begin
      click_button('Continue')
    rescue
      click_link('Continue')
    end
  end
end