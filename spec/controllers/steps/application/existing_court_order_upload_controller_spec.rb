require 'rails_helper'

RSpec.describe Steps::Application::ExistingCourtOrderUploadController, type: :controller do
  it_behaves_like 'an intermediate step controller', Steps::Application::ExistingCourtOrderUploadForm, C100App::ApplicationDecisionTree
end
