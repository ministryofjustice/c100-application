module Steps
  module Opening
    class MyHmctsForm < BaseForm
      include SingleQuestionForm

      yes_no_attribute :is_solicitor, reset_when_no: [:use_my_hmcts]
      attribute :use_my_hmcts, YesNoUnknown

      validates_presence_of :use_my_hmcts, if: lambda {
                                                 is_solicitor&.yes?
                                               }
    end
  end
end
