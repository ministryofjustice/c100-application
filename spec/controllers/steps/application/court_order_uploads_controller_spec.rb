require 'rails_helper'

RSpec.describe Steps::Application::CourtOrderUploadsController,
    type: :controller do
  it_behaves_like 'an intermediate step controller',
      Steps::Application::CourtOrderUploadsForm, C100App::ApplicationDecisionTree do
    before do
      allow_any_instance_of(C100Application).to receive(
        :documents).and_return([])
      allow(controller).to receive(:court_sanity_check).and_return(true)
    end
  end
end
