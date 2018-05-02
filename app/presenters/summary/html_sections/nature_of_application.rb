module Summary
  module HtmlSections
    class NatureOfApplication < Sections::BaseSectionPresenter
      def name
        :nature_of_application
      end

      def answers
        [
          MultiAnswer.new(:petition_orders, petition.all_selected_orders,
                          change_path: edit_steps_petition_orders_path),

          FreeTextAnswer.new(:other_issue_details, petition.other_issue_details,
                             change_path: edit_steps_petition_orders_path(
                               anchor: 'steps_petition_orders_form_other_issue'
                             )),

          AnswersGroup.new(
            :protection_orders,
            [
              Answer.new(:protection_orders, c100.protection_orders),
              FreeTextAnswer.new(:protection_orders_details, c100.protection_orders_details),
            ],
            change_path: edit_steps_petition_protection_path
          ),
        ].select(&:show?)
      end

      private

      def petition
        @_petition ||= PetitionPresenter.new(c100)
      end
    end
  end
end
