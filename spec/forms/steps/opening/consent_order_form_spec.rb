require 'spec_helper'

RSpec.describe Steps::Opening::ConsentOrderForm do
  it_behaves_like 'a yes-no question form',
                  attribute_name: :consent_order,
                  reset_when_yes: [
                    :child_protection_cases,
                    :miam_acknowledgement,
                    :miam_attended,
                    :miam_mediator_exemption,
                    :miam_exemption_claim,
                    :miam_certification,
                  ]
end
