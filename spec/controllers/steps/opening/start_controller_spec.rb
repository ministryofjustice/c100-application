require 'rails_helper'

RSpec.describe Steps::Opening::StartController, type: :controller do
  it_behaves_like 'a controller that checks the application payment status', for_action: :show
end
