require 'spec_helper'

RSpec.describe Steps::Children::HasOtherChildrenForm do
  it_behaves_like 'a yes-no question form', attribute_name: :has_other_children
end
