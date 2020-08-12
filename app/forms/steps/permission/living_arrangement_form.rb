module Steps
  module Permission
    class LivingArrangementForm < QuestionForm
      yes_no_attribute :living_arrangement,
                       reset_when_yes: [
                         :consent
                       ]
    end
  end
end
