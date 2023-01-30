require 'rails_helper'

RSpec.describe Steps::Application::HasCourtOrderUploadsController,
    type: :controller, focus: true do
  it_behaves_like 'an intermediate step controller',
      Steps::Application::HasCourtOrderUploadsForm, C100App::ApplicationDecisionTree do
  end
end
