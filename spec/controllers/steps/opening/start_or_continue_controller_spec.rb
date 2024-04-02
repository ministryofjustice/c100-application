require 'rails_helper'

RSpec.describe Steps::Opening::StartOrContinueController, type: :controller do

  before do
    allow(ENV).to receive(:[]).with("PRL_OPENING").and_return("true")
    allow(ENV).to receive(:fetch).with('MEDIATION_DATE', "29/04/2024").and_return("29/04/2024")
  end

  it_behaves_like 'a starting point step controller'

  describe '#edit' do

    describe 'if existing application with sufficient progress' do
      let(:navigation_stack) { %w[page page page page] }
      let(:existing_case) { C100Application.create(
        status: :in_progress,
        navigation_stack: navigation_stack)
      }

      describe 'without new parameter' do
        it 'redirects to warning page' do
          get :edit, session: { c100_application_id: existing_case.id }
          expect(subject).to redirect_to(steps_opening_warning_path)
        end
      end

      describe 'with new parameter' do
        it 'does not redirect' do
          get :edit, params: { new: 'y' }, session: { c100_application_id: existing_case.id }
          expect(subject).to render_template(:edit)
        end
      end
    end
  end

  describe '#update' do
    let(:form_class) { Steps::Opening::StartOrContinueForm }
    let(:decision_tree_class) { C100App::OpeningDecisionTree }
    let(:form_object) { instance_double(form_class, attributes: { foo: double }) }
    let(:form_class_params_name) { form_class.name.underscore }
    let(:expected_params) { { form_class_params_name => { foo: 'bar' } } }

    context 'when a case in progress is in the session' do
      let(:existing_case) { C100Application.create(status: :in_progress) }

      before do
        allow(form_class).to receive(:new).and_return(form_object)
      end

      context 'when the form saves successfully' do
        before do
          expect(form_object).to receive(:save).and_return(true)
        end

        let(:decision_tree) { instance_double(decision_tree_class, destination: '/expected_destination') }

        it 'asks the decision tree for the next destination and redirects there' do
          expect(decision_tree_class).to receive(:new).and_return(decision_tree)
          put :update, params: expected_params, session: { c100_application_id: existing_case.id }
          expect(subject).to redirect_to('/expected_destination')
        end
      end

      context 'when the form fails to save' do
        before do
          expect(form_object).to receive(:save).and_return(false)
        end

        it 'renders the question page again' do
          put :update, params: expected_params, session: { c100_application_id: existing_case.id }
          expect(subject).to render_template(:edit)
        end
      end
    end
  end


end
