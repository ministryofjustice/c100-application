module Steps
  module Application
    class ExistingCourtOrderUploadableForm < BaseForm
      include SingleQuestionForm

      yes_no_attribute :existing_court_order_uploadable
    end
  end
end
