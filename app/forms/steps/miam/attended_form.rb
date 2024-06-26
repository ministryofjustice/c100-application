module Steps
  module Miam
    class AttendedForm < BaseForm
      include SingleQuestionForm

      yes_no_attribute :miam_attended,
                       reset_when_yes: [
                         :miam_exemption_claim,
                         :miam_exemption,
                       ],
                       reset_when_no: [:miam_certification]
    end
  end
end
