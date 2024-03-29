require 'rails_helper'

RSpec.describe Users::RegistrationsController do
  let(:c100_application) { double.as_null_object }

  before do
    allow(subject).to receive(:current_c100_application).and_return(c100_application)
    request.env['devise.mapping'] = Devise.mappings[:user]
    C100Application.destroy_all
    User.delete_all # ensure no left-overs
  end

  describe '#new' do
    context 'when there is no c100 application in the session' do
      let(:c100_application) { nil }

      it 'redirects to the invalid session error page' do
        get :new
        expect(response).to redirect_to(invalid_session_errors_path)
      end
    end

    context 'when there is a c100 application in the session' do
      it 'responds with HTTP success' do
        get :new
        expect(response).to be_successful
      end
    end
  end

  describe '#create' do
    context 'when there is no c100 application in the session' do
      let(:c100_application) { nil }

      it 'redirects to the invalid session error page' do
        post :create, params: { doesnt: 'matter' }
        expect(response).to redirect_to(invalid_session_errors_path)
      end
    end

    context 'when there is a c100 application in the session' do
      def do_post
        post :create, params: { 'user' => {
          'email' => 'foo@bar.com',
          'password' => 'mypassw0rd'
        } }
      end

      context 'when the registration was successful' do
        before do
          expect(
            C100App::SaveApplicationForLater
          ).to receive(:new).with(
            c100_application, an_instance_of(User)
          ).and_return(double.as_null_object)
        end

        it 'creates the user and redirects to the confirmation page' do
          expect { do_post }.to change{ User.count }.by(1)
          expect(response).to redirect_to(users_registration_save_confirmation_path)
        end
      end

      context 'when the registration was unsuccessful' do
        before do
          expect(C100App::SaveApplicationForLater).not_to receive(:new)
        end

        it 'does not create the user and re-renders the page' do
          post :create, params: { 'user' => {
            'email' => 'foo@bar.com',
            'password' => 'short'
          } }
          expect(subject).to render_template(:new)
        end
      end
    end
  end

  describe '#save_confirmation' do
    context 'when there is no c100 application in the session' do
      let(:c100_application) { nil }

      it 'redirects to the invalid session error page' do
        get :save_confirmation
        expect(response).to redirect_to(invalid_session_errors_path)
      end
    end

    context 'when there is a c100 application in the session' do
      it 'renders the expected page' do
        get :save_confirmation
        expect(response).to render_template(:save_confirmation)
      end

      it 'resets the session after rendering the page' do
        expect(subject).to receive(:reset_c100_application_session)
        get :save_confirmation
      end
    end
  end

  describe '#update_confirmation' do
    it 'renders the expected page' do
      get :update_confirmation
      expect(response).to render_template(:update_confirmation)
    end
  end

  describe '#edit' do
    let(:user) { User.new }

    before do
      sign_in(user)
    end

    it 'responds with HTTP success' do
      get :edit
      expect(response).to be_successful
    end
  end

  describe '#update' do
    let(:user) { User.new }

    before do
      sign_in(user)
      # Bypass Devise database find() so we don't need to persist the test user
      allow(User.to_adapter).to receive(:get!).and_return(user)
    end

    def do_update
      put :update, params: { 'user' => {
        current_password: 'passw0rd',
        password: new_password
      }}
    end

    context 'when the parameters are valid' do
      let(:new_password) { 'passw0rd' }

      before do
        expect(user).to receive(:update_with_password).with(
          hash_including(password: 'passw0rd')
        ).and_return(true)
      end

      it 'redirects to the update confirmation page' do
        do_update
        expect(response).to redirect_to(users_registration_update_confirmation_path)
      end
    end

    context 'when the parameters are not valid' do
      let(:new_password) { '' }

      before do
        expect(user).to receive(:update_with_password).with(hash_including(password: '*')).and_call_original
      end

      it 'renders to the update page' do
        do_update
        expect(subject).to render_template(:edit)
      end
    end
  end
end
