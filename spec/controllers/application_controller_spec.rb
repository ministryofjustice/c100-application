require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    def my_url; render json: {}; end
    def invalid_session; raise Errors::InvalidSession; end
    def application_not_found; raise Errors::ApplicationNotFound; end
    def application_completed; raise Errors::ApplicationCompleted; end
    def application_screening; raise Errors::ApplicationScreening; end
    def payment_error; raise Errors::PaymentError; end
    def another_exception; raise Exception; end
  end

  before do
    allow(Rails.application.config).to receive(:consider_all_requests_local).and_return(false)
    allow(Rails.application.config).to receive(:maintenance_enabled).and_return(nil)
    allow(Rails.configuration).to receive_message_chain(:x, :session, :expires_in_minutes).and_return(1)

    # Set up test routes
    routes.draw do
      root to: 'anonymous#root'
      get 'my_url' => 'anonymous#my_url'
      get 'invalid_session' => 'anonymous#invalid_session'
      get 'application_not_found' => 'anonymous#application_not_found'
      get 'application_completed' => 'anonymous#application_completed'
      get 'application_screening' => 'anonymous#application_screening'
      get 'payment_error' => 'anonymous#payment_error'
      get 'another_exception' => 'anonymous#another_exception'
    end
  end

  context 'Security handling' do
    context '#drop_dangerous_headers!' do
      it 'removes dangerous headers' do
        request.headers.merge!('HTTP_X_FORWARDED_HOST' => 'foobar.com')
        get :my_url
        expect(request.env).not_to include('HTTP_X_FORWARDED_HOST')
      end
    end

    context 'basic HTTP auth' do
      it 'checks for the ENV variable' do
        expect(ENV).to receive(:key?).with('HTTP_AUTH_ENABLED')
        get :my_url
      end
    end
  end

  context 'Session handling' do
    context 'ensure_session_validity' do
      before do
        travel_to Time.at(555555)
      end

      context 'when cookie is not present' do
        it 'sets the `last_seen` value' do
          get :my_url
          expect(session[:last_seen]).to eq(555555)
        end

        it 'does not reset the session' do
          expect(controller).not_to receive(:reset_session)
          get :my_url
        end
      end

      context 'when cookie is present but not expired' do
        before do
          session[:last_seen] = Time.now.to_i
        end

        it 'sets the `last_seen` value' do
          get :my_url
          expect(session[:last_seen]).to eq(555555)
        end

        it 'does not reset the session' do
          expect(controller).not_to receive(:reset_session)
          get :my_url
        end
      end

      context 'when cookie is present but expired' do
        before do
          session[:last_seen] = Time.now.to_i - 155
        end

        it 'sets the `last_seen` value' do
          expect(session[:last_seen]).to eq(555400)
          get :my_url
          expect(session[:last_seen]).to eq(555555)
        end

        it 'resets the session' do
          expect(controller).to receive(:reset_session)
          get :my_url
        end
      end
    end
  end

  context 'Exceptions handling' do
    context 'Errors::InvalidSession' do
      it 'should not report the exception, and redirect to the error page' do
        expect(Sentry).not_to receive(:capture_exception)

        get :invalid_session
        expect(response).to redirect_to('/errors/invalid_session')
      end
    end

    context 'Errors::ApplicationNotFound' do
      it 'should not report the exception, and redirect to the error page' do
        expect(Sentry).not_to receive(:capture_exception)

        get :application_not_found
        expect(response).to redirect_to('/errors/application_not_found')
      end
    end

    context 'Errors::ApplicationScreening' do
      it 'should not report the exception, and redirect to the error page' do
        expect(Sentry).not_to receive(:capture_exception)

        get :application_screening
        expect(response).to redirect_to('/errors/application_screening')
      end
    end

    context 'Errors::ApplicationCompleted' do
      it 'should not report the exception, and redirect to the error page' do
        expect(Sentry).not_to receive(:capture_exception)

        get :application_completed
        expect(response).to redirect_to('/errors/application_completed')
      end
    end

    context 'Errors::PaymentError' do
      it 'should report the exception, and redirect to the payment error page' do
        expect(Sentry).to receive(:capture_exception).with(
          Errors::PaymentError, tags: { c100_application_id: nil }
        )

        get :payment_error
        expect(response).to redirect_to('/errors/payment_error')
      end
    end

    context 'Other exceptions' do
      it 'should report the exception, and redirect to the error page' do
        expect(Sentry).to receive(:capture_exception)

        get :another_exception
        expect(response).to redirect_to('/errors/unhandled')
      end
    end
  end
end
