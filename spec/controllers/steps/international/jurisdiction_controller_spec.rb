require 'rails_helper'

RSpec.describe Steps::International::JurisdictionController, type: :controller do
  it_behaves_like 'an intermediate step controller', Steps::International::JurisdictionForm, C100App::InternationalDecisionTree
end
