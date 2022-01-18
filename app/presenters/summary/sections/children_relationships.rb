module Summary
  module Sections
    class ChildrenRelationships < BaseSectionPresenter
      def name
        :children_relationships
      end

      def answers
        c100.applicants.map.with_index(1) do |applicant, index|
          FreeTextAnswer.new(
            :applicants_relationships,
            RelationshipsPresenter.new(c100_application).relationship_to_children(applicant),
            i18n_opts: { index: index }
          )
        end +
        c100.respondents.map.with_index(1) do |respondent, index|
          FreeTextAnswer.new(
            :respondents_relationships,
            RelationshipsPresenter.new(c100_application).relationship_to_children(respondent),
            i18n_opts: { index: index }
          )
        end + [
          FreeTextAnswer.new(
            :other_parties_relationships,
            RelationshipsPresenter.new(c100_application).relationship_to_children(c100.other_parties)
          ),
          Partial.row_blank_space,
        ].select(&:show?)
      end
    end


    
  end
end
