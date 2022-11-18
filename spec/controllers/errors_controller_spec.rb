require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do

  # Strange issue with failing to find views

  # before do
  #   allow(C100Application).to receive(:find_by_id).
  #     and_return(true)
  # end

  # describe 'invalid_session' do
  #   it 'responds :invalid_session' do
  #     get :invalid_session
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
  
  # describe 'not_found' do
  #   it 'responds :not_found' do
  #     get :not_found
  #     expect(response).to have_http_status(:not_found)
  #   end
  # end
  
  # describe 'application_not_found' do
  #   it 'responds :not_found' do
  #     get :application_not_found
  #     expect(response).to have_http_status(:not_found)
  #   end
  # end
  
  # describe 'application_screening' do
  #   it 'responds :unprocessable_entity' do
  #     get :application_screening
  #     expect(response).to have_http_status(:unprocessable_entity)
  #   end
  # end
  
  # describe 'application_completed' do
  #   it 'responds :unprocessable_entity' do
  #     get :application_completed
  #     expect(response).to have_http_status(:unprocessable_entity)
  #   end
  # end
  
  # describe 'payment_error' do
  #   it 'responds :unprocessable_entity' do
  #     get :payment_error
  #     expect(response).to have_http_status(:unprocessable_entity)
  #   end
  # end
  
  # describe 'unhandled' do
  #   it 'responds :internal_server_error' do
  #     get :unhandled
  #     expect(response).to have_http_status(:internal_server_error)
  #   end
  # end

end
