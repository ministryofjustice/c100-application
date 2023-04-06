require 'rails_helper'

RSpec.describe Steps::Opening::StartOrContinueController, type: :controller do
  it_behaves_like 'a starting point step controller'
  it_behaves_like 'an intermediate step controller', Steps::Opening::StartOrContinueForm, C100App::OpeningDecisionTree
end
