require 'spec_helper'

RSpec.describe Steps::Opening::MyHmctsForm do
  it_behaves_like 'a yes-no question form',
                  attribute_name:   :is_solicitor,
                  linked_attribute: :use_my_hmcts,
                  linked_attribute_example: GenericYesNoUnknown::NO,
                  reset_when_no:    [:use_my_hmcts]
end
