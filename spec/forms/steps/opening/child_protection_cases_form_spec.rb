require 'spec_helper'

RSpec.describe Steps::Opening::ChildProtectionCasesForm do
  it_behaves_like 'a yes-no question form',
                  attribute_name: :child_protection_cases,
                  reset_when_yes: [
                    :miam_acknowledgement,
                    :miam_attended,
                    :miam_exemption_claim,
                    :miam_certification,
                  ]
end
