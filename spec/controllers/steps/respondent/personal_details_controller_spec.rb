require 'rails_helper'

RSpec.describe Steps::Respondent::PersonalDetailsController, type: :controller do
  it_behaves_like 'an intermediate step controller', Steps::Respondent::PersonalDetailsForm, C100App::RespondentDecisionTree
end
