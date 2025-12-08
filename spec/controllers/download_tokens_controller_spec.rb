require 'rails_helper'

RSpec.describe DownloadTokensController, type: :controller do

  let(:c100_application) { C100Application.create }
  let!(:download_token) { c100_application.download_tokens.
                            create(key: '123') }

  before do
    allow_any_instance_of(DownloadToken).to(
      receive(:url).and_return('https://www.example.com'))
  end

  describe '#show' do
    it 'redirects' do
      get :show, params: { token: download_token.token }
      expect(response).to redirect_to('https://www.example.com')
    end

    it 'redirects to file_not_found if not found' do
      get :show, params: { token: 'invalid' }
      expect(response).to redirect_to(file_not_found_errors_path)
    end
  end
end
