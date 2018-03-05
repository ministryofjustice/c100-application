require 'rails_helper'

RSpec.describe Users::DraftsController, type: :controller do
  let(:user) { User.new }

  describe '#index' do
    context 'when user is logged out' do
      it 'redirects to the sign-in page' do
        get :index
        expect(response).to redirect_to(user_session_path)
      end
    end

    context 'when user is logged in' do
      let(:finder_double) { double.as_null_object }

      before do
        sign_in(user)
        expect(user).to receive(:drafts).and_return(finder_double)
      end

      it 'renders the drafts page' do
        get :index
        expect(assigns[:drafts]).not_to be_nil
        expect(response).to render_template(:index)
      end

      it 'sorts the resulting drafts by ascending `created_at`' do
        expect(finder_double).to receive(:order).with(created_at: :asc)
        get :index
      end
    end
  end

  describe '#resume' do
    context 'when user is logged out' do
      it 'redirects to the sign-in page' do
        get :resume, params: { id: 'any' }
        expect(response).to redirect_to(user_session_path)
      end
    end

    context 'when user is logged in' do
      before do
        sign_in(user)
      end

      context 'when c100 application does not exist' do
        it 'redirects to the application not found error page' do
          get :resume, params: {id: '123'}
          expect(response).to redirect_to(application_not_found_errors_path)
        end
      end

      context 'when c100 application exists' do
        let!(:c100_application) { C100Application.create(navigation_stack: %w(/step/1 /step/2)) }
        let(:scoped_result) { double('result') }

        before do
          expect(user).to receive(:drafts).and_return(scoped_result)
          expect(scoped_result).to receive(:find_by).with(id: c100_application.id).and_return(c100_application)
        end

        it 'assigns the chosen c100 application to the current session' do
          expect(session[:c100_application_id]).to be_nil
          get :resume, params: { id: c100_application.id }
          expect(session[:c100_application_id]).to eq(c100_application.id)
        end

        it 'redirects to the last recorded step' do
          get :resume, params: { id: c100_application.id }
          expect(response).to redirect_to('/step/2')
        end
      end
    end
  end

  describe '#destroy' do
    context 'when user is logged out' do
      it 'redirects to the sign-in page' do
        delete :destroy, params: { id: 'any' }
        expect(response).to redirect_to(user_session_path)
      end
    end

    context 'when user is logged in' do
      before do
        sign_in(user)
      end

      context 'when c100 application does not exist' do
        it 'redirects to the application not found error page' do
          delete :destroy, params: { id: '123' }
          expect(response).to redirect_to(application_not_found_errors_path)
        end
      end

      context 'when c100 application exists' do
        let!(:c100_application) { C100Application.create }
        let(:scoped_result) { double('result') }

        before do
          allow(user).to receive(:drafts).and_return(scoped_result)
          allow(scoped_result).to receive(:find_by).with(id: c100_application.id).and_return(c100_application)
        end

        it 'deletes the c100 application by ID' do
          expect {
            delete :destroy, params: { id: c100_application.id }
          }.to change { C100Application.count }.by(-1)
        end

        it 'redirects back to the drafts page' do
          delete :destroy, params: { id: c100_application.id }
          expect(response).to redirect_to(users_drafts_path)
        end
      end
    end
  end
end
