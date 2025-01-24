require 'rails_helper'

RSpec.describe Steps::Opening::RedirectToGuidanceController, type: :controller do
  let(:c100_application) { instance_double(C100Application) }

  before do
    allow(controller).to receive(:current_c100_application).and_return(c100_application)
    allow(controller).to receive(:update_navigation_stack)
  end

  describe '#show' do
    it 'redirects to MyHMCTS guidance' do
      get :show
      expect(response).to redirect_to('https://www.apply-to-court-about-child-arrangements-c100.service.gov.uk/complete-your-application-guidance')
    end
  end
end
