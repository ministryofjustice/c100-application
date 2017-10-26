require 'rails_helper'

RSpec.describe Steps::NatureOfApplication::CaseTypeController, type: :controller do
  it_behaves_like 'a starting point step controller'
  it_behaves_like 'an intermediate step controller', Steps::NatureOfApplication::CaseTypeForm, CaseTypeDecisionTree
end
