require 'rails_helper'

RSpec.describe Steps::Application::ExistingCourtOrderUploadableController, type: :controller do
  it_behaves_like 'an intermediate step controller', Steps::Application::ExistingCourtOrderUploadableForm, C100App::ApplicationDecisionTree
end
