require 'rails_helper'

RSpec.describe Steps::Opening::MyHmctsCreateAccountController, type: :controller do
  let(:c100_application) { instance_double(C100Application) }

  before do
    allow(controller).to receive(:current_c100_application).and_return(c100_application)
    allow(controller).to receive(:update_navigation_stack)
  end

  describe '#show' do
    it 'redirects to MyHMCTS create account' do
      get :show
      expect(response).to redirect_to('https://www.gov.uk/guidance/myhmcts-online-case-management-for-legal-professionals#create-a-myhmcts-account-for-your-organisation')
    end
  end
end
