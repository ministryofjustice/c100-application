require 'spec_helper'

RSpec.describe Steps::Application::ExistingCourtOrderUploadableForm do
  it_behaves_like 'a yes-no question form', attribute_name: :existing_court_order_uploadable
end
