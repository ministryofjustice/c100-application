require 'rails_helper'

RSpec.describe Steps::Opening::ConsentOrderUploadController, type: :controller do
  it_behaves_like 'an intermediate step controller', Steps::Opening::ConsentOrderUploadForm, C100App::OpeningDecisionTree do
    before do
      allow(controller).to receive(:court_sanity_check).and_return(true)
    end
  end
end
