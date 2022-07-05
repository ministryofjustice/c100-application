module Summary
  class JsonPresenter
    DEFAULT_BUNDLE_FORMS ||= [:c100, :c1a, :c8].freeze

    attr_reader :c100_application

    # delegate :to_pdf, :has_forms_data?, to: :pdf_generator

    def initialize(c100_application)
      @c100_application = c100_application
    end

    def generate(*args)
      forms = args.presence || DEFAULT_BUNDLE_FORMS

      [{
        solicitor: [solicitor_json],
        header: {},
        id: @c100_application.id,
        children: children,
        applicants: applicants,
        respondents: respondents,
        typeOfApplication: type_of_application,
        hearingUrgency: hearing_urgency,
        miam: {},
        allegationsOfHarm: {},
        otherPeopleInTheCase: {},
        otherProceedings: {},
        attendingTheHearing: {},
        internationalElement: {},
        litigationCapacity: {},
        feeAmount: {},
        familyManNumber: {},
        others: {},
        events: {}
      }]
    end

    def filename
      'C100 child arrangements application.json'.freeze
    end

    private

    def solicitor_json
      solicitor = @c100_application.solicitor

      {name: solicitor.full_name,
       address: map_address_data(solicitor.address_data),
       contactDX: solicitor.dx_number,
       contactEmailAddress: solicitor.email,
       reference: solicitor.reference,
       ID: solicitor.id,
       organisationID: nil,
       organisationName: solicitor.firm_name}
    end

    def map_address_data(address_data)
      {
        County: nil,
        Country: address_data["country"],
        PostCode: address_data["postcode"],
        PostTown: address_data["town"],
        AddressLine1: address_data["address_line_1"],
        AddressLine2: address_data["address_line_2"],
        AddressLine3: address_data["address_line_3"]
      }
    end

    def children
      children_data = []
      @c100_application.children.each do |child|
        children_data << child_json(child)
      end
      children_data
    end

    def applicants
      applicants_data = []
      @c100_application.applicants.each do |applicant|
        applicants_data << applicant_json(applicant)
      end
      applicants_data
    end

    def respondents
      respondents_data = []
      @c100_application.respondents.each do |respondent|
        respondents_data << respondent_json(respondent)
      end
      respondents_data
    end

    def hearing_urgency
      {isCaseUrgent: @c100_application.urgent_hearing,
       setOutReasonsBelow: @c100_application.urgent_hearing_details,
       caseUrgencyTimeAndReason: @c100_application.urgent_hearing_when,
       # effortsMadeWithRespondents: nil,
       doYouNeedAWithoutNoticeHearing: @c100_application.without_notice,
       # areRespondentsAwareOfProceedings: "No",
       reasonsForApplicationWithoutNotice: @c100_application.without_notice_details,
       doYouRequireAHearingWithReducedNotice: @c100_application.urgent_hearing_short_notice}
    end

    private

    def child_json(child)
      {
        firstName: child.first_name,
        lastName: child.last_name,
        dateOfBirth: child.dob.to_s(:db),
        gender: child.gender,
        childLiveWith: child.first_name,
        parentalResponsibilityDetails: child.parental_responsibility,
        # "orderAppliedFor"=>"Child Arrangements Order",
        # "applicantsRelationshipToChild"=>"Father",
        # "respondentsRelationshipToChild"=>"Guardian",
        # "otherApplicantsRelationshipToChild"=>nil,
        # "otherRespondentsRelationshipToChild"=>nil,
        # "personWhoLivesWithChild"=>[]
      }
    end

    def applicant_json(applicant)
      {
        firstName: applicant.first_name,
        lastName: applicant.last_name,
        previousName: applicant.previous_name,
        dateOfBirth: applicant.dob.to_s(:db),
        gender: applicant.gender,
        email: applicant.email,
        phoneNumber: applicant.mobile_phone,
        placeOfBirth: applicant.birthplace,
        address: map_address_data(applicant.address_data),
        isAtAddressLessThan5Years: "No",
        addressLivedLessThan5YearsDetails: nil,
        isAddressConfidential: yes_no(applicant.residence_keep_private),
        isPhoneNumberConfidential: yes_no(applicant.mobile_keep_private),
        isEmailAddressConfidential: yes_no(applicant.email_keep_private)
      }
    end

    def respondent_json(respondent)
      {
        firstName: respondent.first_name,
        lastName: respondent.last_name,
        previousName: respondent.previous_name,
        dateOfBirth: respondent_dob(respondent),
        isDateOfBirthKnown: yes_no(respondent.dob.present?),
        gender: respondent.gender,
        email: respondent.email,
        phoneNumber: respondent.mobile_phone,
        isPlaceOfBirthKnown: yes_no(respondent.birthplace.present?),
        placeOfBirth: respondent.birthplace,
        isCurrentAddressKnown: yes_no(respondent.address_data.present?),
        address: map_address_data(respondent.address_data),
        isAtAddressLessThan5Years: "No",
        addressLivedLessThan5YearsDetails: nil,
        isAddressConfidential: yes_no(respondent.residence_keep_private),
        canYouProvidePhoneNumber: yes_no(!respondent.mobile_keep_private),
        canYouProvideEmailAddress: yes_no(!respondent.email_keep_private)
      }
    end

    def type_of_application
      child = @c100_application.children
      {orderAppliedFor: order_type_answers(@c100_application.children),
       typeOfChildArrangementsOrder: order_arrangements,
       # natureOfOrder: "egb",
       consentOrder: @c100_application.consent_order,
       applicationPermissionRequired: @c100_application.permission_sought,
       applicationPermissionRequiredReason: @c100_application.permission_details,
       applicationDetails: @c100_application.application_details }
    end

    def yes_no(value)
      return 'No' if value == false
      'Yes' if value == true
    end

    def respondent_dob(respondent)
      dob = respondent.try(:dob)
      dob.to_s(:db) if dob
    end

    def order_type_answers(children)
      orders = []
      children.each do |child|
       orders << order_types(child).map{|order_value|
          I18n.t(".dictionary.PETITION_ORDER_TYPES.#{order_value}")
        }
      end
      orders.flatten.join(', ')
    end

    def order_arrangements
      orders = []
      @c100_application.orders.each do |order|
        orders << I18n.t(".dictionary.ARRANGEMENT_ORDERS.#{order}")
      end
      orders.flatten.join(', ')
    end

    def order_types(child)
      child.child_order&.orders.to_a.map do |o|
        PetitionOrder.type_for(o)
      end.uniq
    end

  end
end
