module Summary
  module JsonSections
    class Child < Sections::BaseJsonPresenter
      attr_reader :c100_application
      attr_reader :section_hash

      alias_attribute :c100, :c100_application

      def initialize(c100_application)
        super()
        @c100_application = c100_application
        @section_hash = children
      end

      def children
        children_data = []
        c100_application.children.each do |child|
          children_data << child_json(child)
        end

        children_data
      end

      def child_json(child)
        relations = relationship_to_child(child)
        {
          firstName: child.first_name,
          lastName: child.last_name,
          dateOfBirth: child_dob(child),
          gender: child.gender,
          childLiveWith: child_live_with(child),
          parentalResponsibilityDetails: child.parental_responsibility,
          # "orderAppliedFor"=>"Child Arrangements Order",
          applicantsRelationshipToChild: relations['Applicant'],
          respondentsRelationshipToChild: relations['Respondent'],
          otherApplicantsRelationshipToChild: relations['OtherParty'],
          # "otherRespondentsRelationshipToChild"=>nil,
          # "personWhoLivesWithChild"=>[]
        }
      end

      def child_dob(child)
        return "" if child.dob.nil?

        child.dob.to_fs(:db)
      end

      def relationship_to_child(child)
        child.relationships.each_with_object({}) do |l, t|
          name = Person.find(l.person_id).class.name
          t[name] = l.relation
        end
      end

      def child_live_with(child)
        return nil if child.child_residence.blank?
        people = Person.find(child.child_residence.person_ids)
        people.map { |person| person.class.name }
      end
    end
  end
end
