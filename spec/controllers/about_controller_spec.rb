require 'rails_helper'

RSpec.describe AboutController do
  describe '#accessibility' do
    it 'renders the expected page' do
      get :accessibility
      expect(response).to render_template(:accessibility)
    end
  end

  describe '#contact' do
    it 'renders the expected page' do
      get :contact
      expect(response).to render_template(:contact)
    end
  end

  describe '#cookies' do
    it 'renders the expected page' do
      get :cookies
      expect(response).to render_template(:cookies)
    end
  end

  describe '#privacy' do
    it 'renders the expected page' do
      get :privacy
      expect(response).to render_template(:privacy)
    end
  end

  describe '#terms_and_conditions' do
    it 'renders the expected page' do
      get :terms_and_conditions
      expect(response).to render_template(:terms_and_conditions)
    end
  end

  describe '#privacy_consent' do
    it 'renders the expected page' do
      get :privacy_consent
      expect(response).to render_template(:privacy_consent)
    end
  end
end
