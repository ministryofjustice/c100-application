require 'rails_helper'

RSpec.describe Steps::Applicant::RelationshipController, type: :controller do
  it_behaves_like 'a relationship step controller', Steps::Applicant::RelationshipForm, C100App::ApplicantDecisionTree
end
