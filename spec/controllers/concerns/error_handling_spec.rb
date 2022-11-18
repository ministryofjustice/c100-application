require 'rails_helper'

RSpec.describe ErrorHandling do

  before do
    @controller = ErrorsController.new
  end

  it 'can check for c100_application' do
    get :application_screening
    expect(response).to redirect_to(invalid_session_errors_path)
  end
end
