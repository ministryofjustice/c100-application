require 'rails_helper'

RSpec.describe Steps::Opening::ConsentOrderUploadController, type: :controller, focus: true do
  it_behaves_like 'an intermediate step controller', Steps::Opening::ConsentOrderUploadForm, C100App::OpeningDecisionTree
end
