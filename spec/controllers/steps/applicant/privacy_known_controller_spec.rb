require 'rails_helper'

RSpec.describe Steps::Applicant::PrivacyKnownController, type: :controller, focus: true do
  it_behaves_like 'an intermediate step controller', Steps::Applicant::PrivacyKnownForm, C100App::ApplicantDecisionTree
  it_behaves_like 'a step that can fast-forward to check your answers', Steps::Applicant::PrivacyKnownForm
end
