def base_page
  @base_page ||= BasePage.new
end

def home_page
  @home_page ||= HomePage.new
end

def what_you_need_page
  @what_you_need_page ||= WhatYouNeedPage.new
end

def consent_order_page
  @consent_order_page ||= ConsentOrderPage.new
end

def upload_consent_order_page
  @upload_consent_order_page ||= UploadConsentOrderPage.new
end

def child_protection_case_page
  @child_protection_case_page ||= ChildProtectionCasePage.new
end

def child_protection_info_page
  @child_protection_info_page ||= ChildProtectionInfoPage.new
end

def miam_acknowledgement_page
  @miam_acknowledgement_page ||= MiamAcknowledgementPage.new
end

def miam_attended_page
  @miam_attended_page ||= MiamAttendedPage.new
end

def miam_exemption_claim_page
  @miam_exemption_claim_page ||= MiamExemptionClaimPage.new
end

def miam_exemptions_adr_page
  @miam_exemptions_adr_page ||= MiamExemptionsAdrPage.new
end

def miam_exemptions_details_page
  @miam_exemptions_details_page ||= MiamExemptionsDetailsPage.new
end

def miam_exemptions_domestic_page
  @miam_exemptions_domestic_page ||= MiamExemptionsDomesticPage.new
end

def miam_exemptions_misc_page
  @miam_exemptions_misc_page ||= MiamExemptionsMiscPage.new
end

def miam_exemptions_protection_page
  @miam_exemptions_protection_page ||= MiamExemptionsProtectionPage.new
end

def miam_exemptions_reasons_page
  @miam_exemptions_reasons_page ||= MiamExemptionsReasonsPage.new
end

def miam_exemptions_exemption_upload_page
  @miam_exemptions_exemption_upload_page ||= MiamExemptionsExemptionUploadPage.new
end

def miam_exemptions_reasons_playback_page
  @miam_exemptions_reasons_playback_page ||= MiamExemptionsReasonsPlaybackPage.new
end

def miam_exemptions_urgency_page
  @miam_exemptions_urgency_page ||= MiamExemptionsUrgencyPage.new
end

def miam_certification_page
  @miam_certification_page ||= MiamCertificationPage.new
end

def miam_certification_exit_page
  @miam_certification_exit_page ||= MiamCertificationExitPage.new
end

def miam_certification_upload_page
  @miam_certification_upload_page ||= MiamCertificationUploadPage.new
end

def miam_page
  @miam_page ||= MiamPage.new
end

def safety_concern_page
  @safety_concern_page ||= SafetyConcernPage.new
end

def safety_concern_abduction_page
  @safety_concern_abduction_page ||= SafetyConcernAbductionPage.new
end

def abduction_children_have_passport_page
  @abduction_children_have_passport_page ||= AbductionChildrenHavePassportPage.new
end

def abduction_international_page
  @abduction_international_page ||= AbductionInternationalPage.new
end

def abduction_passport_details_page
  @abduction_passport_details_page ||= AbductionPassportDetailsPage.new
end

def abduction_previous_attempt_details_page
  @abduction_previous_attempt_details_page ||= AbductionPreviousAttemptDetailsPage.new
end

def abduction_previous_attempt_page
  @abduction_previous_attempt_page ||= AbductionPreviousAttemptPage.new
end

def abduction_risk_details_page
  @abduction_risk_details_page ||= AbductionRiskDetailsPage.new
end

def abuse_concerns_page
  @abuse_concerns_page ||= AbuseConcernsPage.new
end

def abuse_concerns_children_info_page
  @abuse_concerns_children_info_page ||= AbuseConcernsChildrenInfoPage.new
end

def abuse_concerns_question_page
  @abuse_concerns_question_page ||= AbuseConcernsQuestionPage.new
end

def abuse_concerns_physical_page
  @abuse_concerns_physical_page ||= AbuseConcernsPhysicalPage.new
end

def abuse_concerns_financial_page
  @abuse_concerns_financial_page ||= AbuseConcernsFinancialPage.new
end

def abuse_concerns_financial_details_page
  @abuse_concerns_financial_details_page ||= AbuseConcernsFinancialDetailsPage.new
end

def abuse_concerns_psychological_page
  @abuse_concerns_psychological_page ||= AbuseConcernsPsychologicalPage.new
end

def abuse_concerns_emotional_page
  @abuse_concerns_emotional_page ||= AbuseConcernsEmotionalPage.new
end

def abuse_concerns_children_other_page
  @abuse_concerns_children_other_page ||= AbuseConcernsChildrenOtherPage.new
end

def abuse_concerns_children_other_details_page
  @abuse_concerns_children_other_details_page ||= AbuseConcernsChildrenOtherDetailsPage.new
end

def abuse_concerns_applicant_info_page
  @abuse_concerns_applicant_info_page ||= AbuseConcernsApplicantInfoPage.new
end

def abuse_concerns_applicant_question_page
  @abuse_concerns_applicant_question_page ||= AbuseConcernsApplicantQuestionPage.new
end

def abuse_concerns_applicant_physical_page
  @abuse_concerns_applicant_physical_page ||= AbuseConcernsApplicantPhysicalPage.new
end

def abuse_concerns_applicant_financial_page
  @abuse_concerns_applicant_financial_page ||= AbuseConcernsApplicantFinancialPage.new
end

def abuse_concerns_applicant_psychological_page
  @abuse_concerns_applicant_psychological_page ||= AbuseConcernsApplicantPsychologicalPage.new
end

def abuse_concerns_applicant_emotional_page
  @abuse_concerns_applicant_emotional_page ||= AbuseConcernsApplicantEmotionalPage.new
end

def abuse_concerns_applicant_other_page
  @abuse_concerns_applicant_other_page ||= AbuseConcernsApplicantOtherPage.new
end

def applicant_has_protection_court_order_page
  @applicant_has_protection_court_order_page ||= ApplicantHasProtectionCourtOrderPage.new
end

def abuse_concerns_contact_page
  @abuse_concerns_contact_page ||= AbuseConcernsContactPage.new
end

def abuse_concerns_psychological_details_page
  @abuse_concerns_psychological_details_page ||= AbuseConcernsPsychologicalDetailsPage.new
end

def abuse_concerns_emotional_details_page
  @abuse_concerns_emotional_details_page ||= AbuseConcernsEmotionalDetailsPage.new
end

def abuse_concerns_applicant_question_details_page
  @abuse_concerns_applicant_question_details_page ||= AbuseConcernsApplicantQuestionDetailsPage.new
end

def abuse_concerns_applicant_physical_details_page
  @abuse_concerns_applicant_physical_details_page ||= AbuseConcernsApplicantPhysicalDetailsPage.new
end

def abuse_concerns_applicant_financial_details_page
  @abuse_concerns_applicant_financial_details_page ||= AbuseConcernsApplicantFinancialDetailsPage.new
end

def abuse_concerns_applicant_psychological_details_page
  @abuse_concerns_applicant_psychological_details_page ||= AbuseConcernsApplicantPsychologicalDetailsPage.new
end

def abuse_concerns_applicant_emotional_details_page
  @abuse_concerns_applicant_emotional_details_page ||= AbuseConcernsApplicantEmotionalDetailsPage.new
end

def abuse_concerns_applicant_other_details_page
  @abuse_concerns_applicant_other_details_page ||= AbuseConcernsApplicantOtherDetailsPage.new
end

def safety_concern_substance_page
  @safety_concern_substance_page ||= SafetyConcernSubstancePage.new
end

def safety_concern_abuse_page
  @safety_concern_abuse_page ||= SafetyConcernAbusePage.new
end

def safety_concern_domestic_page
  @safety_concern_domestic_page ||= SafetyConcernDomesticPage.new
end

def safety_concern_other_page
  @safety_concern_other_page ||= SafetyConcernOtherPage.new
end

def petition_orders_page
  @petition_orders_page ||= PetitionOrdersPage.new
end

def petition_playback_page
  @petition_playback_page ||= PetitionPlaybackPage.new
end

def petition_protection_page
  @petition_protection_page ||= PetitionProtectionPage.new
end

def alternative_court_page
  @alternative_court_page ||= AlternativeCourtPage.new
end

def alternative_page
  @alternative_page ||= AlternativePage.new
end

def alternative_negotiation_page
  @alternative_negotiation_page ||= AlternativeNegotiationPage.new
end

def alternative_mediation_page
  @alternative_mediation_page ||= AlternativeMediationPage.new
end

def alternative_lawyer_page
  @alternative_lawyer_page ||= AlternativeLawyerPage.new
end

def alternative_collaborative_law_page
  @alternative_collaborative_law_page ||= AlternativeCollaborativeLawPage.new
end

def children_names_page
  @children_names_page ||= ChildrenNamesPage.new
end

def child_personal_details_page
  @child_personal_details_page ||= ChildPersonalDetailsPage.new
end

def child_orders_page
  @child_orders_page ||= ChildOrdersPage.new
end

def other_children_names_page
  @other_children_names_page ||= OtherChildrenNamesPage.new
end

def other_children_personal_details_page
  @other_children_personal_details_page ||= OtherChildrenPersonalDetailsPage.new
end

def special_guardianship_page
  @special_guardianship_page ||= SpecialGuardianshipPage.new
end

def parental_responsibility_page
  @parental_responsibility_page ||= ParentalResponsibilityPage.new
end

def child_additional_details_page
  @child_additional_details_page ||= ChildAdditionalDetailsPage.new
end

def has_other_children_page
  @has_other_children_page ||= HasOtherChildrenPage.new
end

def applicant_names_page
  @applicant_names_page ||= ApplicantNamesPage.new
end

def applicant_privacy_known_page
  @applicant_privacy_known_page ||= ApplicantPrivacyKnownPage.new
end

def applicant_privacy_preferences_page
  @applicant_privacy_preferences_page ||= ApplicantPrivacyPreferencesPage.new
end

def applicant_privacy_summary_page
  @applicant_privacy_summary_page ||= ApplicantPrivacySummaryPage.new
end

def applicant_refuge_page
  @applicant_refuge_page ||= ApplicantRefugePage.new
end

def applicant_personal_details_page
  @applicant_personal_details_page ||= ApplicantPersonalDetailsPage.new
end

def applicant_relationship_page
  @applicant_relationship_page ||= ApplicantRelationshipPage.new
end

def address_lookup_page
  @address_lookup_page ||= AddressLookupPage.new
end

def applicant_address_details_page
  @applicant_address_details_page ||= ApplicantAddressDetailsPage.new
end

def applicant_contact_details_page
  @applicant_contact_details_page ||= ApplicantContactDetailsPage.new
end

def applicant_has_solicitor_page
  @applicant_has_solicitor_page ||= ApplicantHasSolicitorPage.new
end

def solicitor_personal_details_page
  @solicitor_personal_details_page ||= SolicitorPersonalDetailsPage.new
end

def solicitor_address_details_page
  @solicitor_address_details_page ||= SolicitorAddressDetailsPage.new
end

def solicitor_contact_details_page
  @solicitor_contact_details_page ||= SolicitorContactDetailsPage.new
end

def respondent_names_page
  @respondent_names_page ||= RespondentNamesPage.new
end

def respondent_personal_details_page
  @respondent_personal_details_page ||= RespondentPersonalDetailsPage.new
end

def respondent_relationship_page
  @respondent_relationship_page ||= RespondentRelationshipPage.new
end

def respondent_address_lookup_page
  @respondent_address_lookup_page ||= RespondentAddressLookupPage.new
end

def respondent_address_details_page
  @respondent_address_details_page ||= RespondentAddressDetailsPage.new
end

def respondent_contact_details_page
  @respondent_contact_details_page ||= RespondentContactDetailsPage.new
end

def respondent_refuge_page
  @respondent_refuge_page ||= RespondentRefugePage.new
end

def has_other_parties_page
  @has_other_parties_page ||= HasOtherPartiesPage.new
end

def other_party_names_page
  @other_party_names_page ||= OtherPartyNamesPage.new
end

def other_party_personal_details_page
  @other_party_personal_details_page ||= OtherPartyPersonalDetailsPage.new
end

def other_party_address_details_page
  @other_party_address_details_page ||= OtherPartyAddressDetailsPage.new
end

def other_party_children_cohabit_page
  @other_party_children_cohabit_page ||= OtherPartyChildrenCohabitPage.new
end

def other_party_identity_preferences_page
  @other_party_identity_preferences_page ||= OtherPartyIdentityPreferencesPage.new
end

def other_party_privacy_preferences_page
  @other_party_privacy_preferences_page ||= OtherPartyPrivacyPreferencesPage.new
end

def other_party_refuge_page
  @other_party_refuge_page ||= OtherPartyRefugePage.new
end

def child_residence_page
  @child_residence_page ||= ChildResidencePage.new
end

def previous_proceedings_page
  @previous_proceedings_page ||= PreviousProceedingsPage.new
end

def previous_court_proceedings_page
  @previous_court_proceedings_page ||= PreviousCourtProceedingsPage.new
end

def existing_court_order_page
  @existing_court_order_page ||= ExistingCourtOrderPage.new
end

def existing_court_order_uploadable_page
  @existing_court_order_uploadable_page ||= ExistingCourtOrderUploadablePage.new
end

def existing_court_order_upload_page
  @existing_court_order_upload_page ||= ExistingCourtOrderUploadPage.new
end

def urgent_hearing_page
  @urgent_hearing_page ||= UrgentHearingPage.new
end

def urgent_hearing_details_page
  @urgent_hearing_details_page ||= UrgentHearingDetailsPage.new
end

def without_notice_page
  @without_notice_page ||= WithoutNoticePage.new
end

def without_notice_details_page
  @without_notice_details_page ||= WithoutNoticeDetailsPage.new
end

def international_resident_page
  @international_resident_page ||= InternationalResidentPage.new
end

def international_jurisdiction_page
  @international_jurisdiction_page ||= InternationalJurisdictionPage.new
end

def international_request_page
  @international_request_page ||= InternationalRequestPage.new
end

def application_details_page
  @application_details_page ||= ApplicationDetailsPage.new
end

def litigation_capacity_page
  @litigation_capacity_page ||= LitigationCapacityPage.new
end

def litigation_capacity_details_page
  @litigation_capacity_details_page ||= LitigationCapacityDetailsPage.new
end

def attending_court_intermediary_page
  @attending_court_intermediary_page ||= AttendingCourtIntermediaryPage.new
end

def attending_court_language_page
  @attending_court_language_page ||= AttendingCourtLanguagePage.new
end

def attending_court_special_arrangements_page
  @attending_court_special_arrangements_page ||= AttendingCourtSpecialArrangementsPage.new
end

def attending_court_special_assistance_page
  @attending_court_special_assistance_page ||= AttendingCourtSpecialAssistancePage.new
end

def submission_page
  @submission_page ||= SubmissionPage.new
end

def submission_email_check_page
  @submission_email_check_page ||= SubmissionEmailCheckPage.new
end

def application_payment_page
  @application_payment_page ||= ApplicationPaymentPage.new
end

def cya_page
  @cya_page ||= CYAPage.new
end

def cookie_management_page
  @cookie_management_page ||= CookieManagementPage.new
end

def completion_confirmation_page
  @completion_confirmation_page ||= CompletionConfirmationPage.new
end

def get_birthdate(age)
  today = Date.today
  dob_date = today - age.to_i.years

  day = dob_date.day.to_s.rjust(2, '0')
  month = dob_date.month.to_s.rjust(2, '0')
  year = dob_date.year

  "#{day}-#{month}-#{year}"
end

def stub_courtfinder_api
  court_id = 'e42e35db-979e-4b6b-8d5d-8b45437cd5f5'

  stub_resp = [
    {
      'courtId' => court_id,
      'courtName' => 'Coventry Combined Court Centre',
      'courtSlug' => 'coventry-combined-court-centre',
      'distance' => 0.24961217877368963
    }
  ]

  court_lookup_resp = {
    'id' => court_id,
    'name' => 'Coventry Combined Court Centre',
    'slug' => 'coventry-combined-court-centre',
    'open' => true,
    'courtAddresses' => [
      {
        'courtId' => court_id,
        'addressType' => 'VISIT_OR_CONTACT_US',
        'addressLine1' => 'Coventry Combined Courts Centre',
        'addressLine2' => 'Much Park Street',
        'postcode' => 'CV1 2SN',
        'townCity' => 'Coventry',
        'county' => 'West Midlands'
      }
    ],
    'courtCodes' => [
      {
        'courtId' => court_id,
        'countyCourtCode' => 180,
        'crownCourtCode' => 417,
        'familyCourtCode' => 180,
        'gbs' => 'Y260'
      }
    ],
    'courtContactDetails' => [
      {
        'courtId' => court_id,
        'email' => 'children.coventry.countycourt@justice.gov.uk',
        'explanation' => '',
        'courtContactDescription' => {
          'name' => 'Family court enquiries'
        }
      }
    ]
  }

  C100App::NewCourtfinderApi.any_instance.stub(:court_for).and_return(stub_resp)
  C100App::NewCourtfinderApi.any_instance.stub(:court_lookup).and_return(court_lookup_resp)
end