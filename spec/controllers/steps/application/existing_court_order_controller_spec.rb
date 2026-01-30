require 'rails_helper'

RSpec.describe Steps::Application::ExistingCourtOrderController, type: :controller do
  it_behaves_like 'an intermediate step controller', Steps::Application::ExistingCourtOrderForm, C100App::ApplicationDecisionTree
end
