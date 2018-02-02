module Summary
  module Sections
    class BaseChildrenDetails < BaseSectionPresenter
      protected

      def personal_details(child)
        [
          FreeTextAnswer.new(:child_full_name, child.full_name),
          DateAnswer.new(:child_dob, child.dob),
          FreeTextAnswer.new(:child_age_estimate, child.age_estimate), # This shows only if a value is present
          Answer.new(:child_sex, child.gender),
        ]
      end

      def relationships(child)
        [
          MultiAnswer.new(:child_applicants_relationship,  relation_to_child(child, c100.applicants)),
          MultiAnswer.new(:child_respondents_relationship, relation_to_child(child, c100.respondents)),
        ]
      end

      private

      def relation_to_child(child, people)
        child.relationships.where(person: people).pluck(:relation)
      end
    end
  end
end
