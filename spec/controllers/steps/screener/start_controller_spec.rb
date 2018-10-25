require 'rails_helper'

RSpec.describe Steps::Screener::StartController, type: :controller do
  let!(:existing_c100) { C100Application.create(status: status, navigation_stack: navigation_stack) }

  before do
    allow(controller).to receive(:current_c100_application).and_return(existing_c100)
  end

  describe '#show' do
    context 'when an existing application in progress exists' do
      let(:status) { :in_progress }

      context 'with enough steps advanced' do
        let(:navigation_stack) { %w(/1 /2 /3) }

        context 'and user bypass the warning' do
          it 'responds with HTTP success' do
            get :show, session: { c100_application_id: existing_c100.id }, params: {new: 'y'}
            expect(response).to be_successful
          end

          it 'resets the c100_application session data' do
            expect(session).to receive(:delete).with(:c100_application_id).ordered
            expect(session).to receive(:delete).with(:last_seen).ordered
            expect(session).to receive(:delete) # any other deletes
            get :show, session: { c100_application_id: existing_c100.id }, params: {new: 'y'}
          end
        end

        context 'and user do not bypass the warning' do
          it 'redirects to the warning page' do
            get :show, session: { c100_application_id: existing_c100.id }
            expect(response).to redirect_to(steps_screener_warning_path)
          end

          it 'does not reset any application session data' do
            expect(session).not_to receive(:delete).with(:c100_application_id).ordered
            expect(session).not_to receive(:delete).with(:last_seen).ordered
            get :show, session: { c100_application_id: existing_c100.id }
          end
        end
      end

      context 'with not enough steps advanced' do
        let(:navigation_stack) { %w(/1 /2) }

        it 'responds with HTTP success' do
          get :show, session: { c100_application_id: existing_c100.id }
          expect(response).to be_successful
        end

        it 'resets the c100_application session data' do
          expect(session).to receive(:delete).with(:c100_application_id).ordered
          expect(session).to receive(:delete).with(:last_seen).ordered
          expect(session).to receive(:delete) # any other deletes
          get :show
        end
      end
    end

    context 'when an existing screening application exists' do
      let(:status) { :screening }
      let(:navigation_stack) { [] }

      it 'responds with HTTP success' do
        get :show, session: { c100_application_id: existing_c100.id }
        expect(response).to be_successful
      end

      it 'resets the c100_application session data' do
        expect(session).to receive(:delete).with(:c100_application_id).ordered
        expect(session).to receive(:delete).with(:last_seen).ordered
        expect(session).to receive(:delete) # any other deletes
        get :show
      end
    end

    context 'when no application exists in session' do
      let!(:existing_c100) { nil }
      let(:navigation_stack) { [] }

      it 'responds with HTTP success' do
        get :show
        expect(response).to be_successful
      end

      it 'resets the c100_application session data' do
        expect(session).to receive(:delete).with(:c100_application_id).ordered
        expect(session).to receive(:delete).with(:last_seen).ordered
        expect(session).to receive(:delete) # any other deletes
        get :show
      end
    end
  end
end
