require 'rails_helper'

RSpec.describe Steps::Miam::CertificationUploadController, type: :controller do
  it_behaves_like 'an intermediate step controller', Steps::Miam::CertificationUploadForm, C100App::MiamDecisionTree do
    before do
      allow(controller).to receive(:court_sanity_check).and_return(true)
    end
  end
end
