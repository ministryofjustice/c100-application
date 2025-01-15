require 'rails_helper'

RSpec.describe Steps::Opening::PostcodeController, type: :controller do

  before do
    allow(PrlChange).to receive(:changes_apply?).and_return(true)
  end

  it_behaves_like 'a starting point step controller'
  it_behaves_like 'an intermediate step controller', Steps::Opening::PostcodeForm, C100App::OpeningDecisionTree
end

