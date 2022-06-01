require 'rails_helper'

RSpec.describe Steps::Children::ParentalResponsibilityController, type: :controller do
  it_behaves_like 'an intermediate step controller',
    Steps::Children::ParentalResponsibilityForm, C100App::ChildrenDecisionTree
end
