require 'spec_helper'

RSpec.describe Steps::Opening::SignInOrCreateAccountForm do
  it_behaves_like 'a yes-no question form',
                  attribute_name: :has_myhmcts_account
end
