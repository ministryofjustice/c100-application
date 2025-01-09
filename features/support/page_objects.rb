module C100
  module Test
    module PageObjects
      # @return [C100::Test::PageObjects::CookieManagementPage]
      def cookie_management_page
        CookieManagementPage.new
      end

      # Abduction pages
      def abduction_children_have_passport_page
        Abduction::ChildrenHavePassportPage.new
      end

      def abduction_international_page
        Abduction::InternationalPage.new
      end

      def abduction_passport_details_page
        Abduction::PassportDetailsPage.new
      end

      def abduction_previous_attempt_details_page
        Abduction::PreviousAttemptDetailsPage.new
      end

      def abduction_previous_attempt_page
        Abduction::PreviousAttemptPage.new
      end

      def abduction_risk_details_page
        Abduction::RiskDetailsPage.new
      end

      # Abuse concerns pages
      def abuse_concerns_applicant_info_page
        AbuseConcerns::ApplicantInfoPage.new
      end

      def abuse_concerns_children_info_page
        AbuseConcerns::ChildrenInfoPage.new
      end

      def abuse_concerns_contact_page
        AbuseConcerns::ContactPage.new
      end

      def abuse_concerns_details_page
        AbuseConcerns::DetailsPage.new
      end

      def abuse_concerns_question_page
        AbuseConcerns::QuestionPage.new
      end

      def abuse_concerns_start_page
        AbuseConcerns::StartPage.new
      end

      # Address pages
      def address_lookup_page
        Address::LookupPage.new
      end

      # Alternatives pages
      def alternatives_collaborative_law_page
        Alternatives::CollaborativeLawPage.new
      end

      def alternatives_court_page
        Alternatives::CourtPage.new
      end

      def alternatives_lawyer_negotiation_page
        Alternatives::LawyerNegotiationPage.new
      end

      def alternatives_mediation_page
        Alternatives::MediationPage.new
      end

      def alternatives_negotiation_tools_page
        Alternatives::NegotiationToolsPage.new
      end

      def alternatives_start_page
        Alternatives::StartPage.new
      end

      # Applicant pages
      def applicant_address_details_page
        Applicant::AddressDetailsPage.new
      end

      def applicant_contact_details_page
        Applicant::ContactDetailsPage.new
      end

      def applicant_has_solicitor_page
        Applicant::HasSolicitorPage.new
      end

      def applicant_names_page
        Applicant::NamesPage.new
      end

      def applicant_personal_details_page
        Applicant::PersonalDetailsPage.new
      end

      def applicant_privacy_known_page
        Applicant::PrivacyKnownPage.new
      end

      def applicant_privacy_preferences_page
        Applicant::PrivacyPreferencesPage.new
      end

      def applicant_privacy_summary_page
        Applicant::PrivacySummaryPage.new
      end

      def applicant_refuge_page
        Applicant::RefugePage.new
      end

      def applicant_relationship_page
        Applicant::RelationshipPage.new
      end

      def applicant_under_age_page
        Applicant::UnderAgePage.new
      end

      # Application pages
      def application_check_your_answers_page
        Application::CheckYourAnswersPage.new
      end

      def application_court_proceedings_page
        Application::CourtProceedingsPage.new
      end

      def application_details_page
        Application::DetailsPage.new
      end

      def application_litigation_capacity_details_page
        Application::LitigationCapacityDetailsPage.new
      end

      def application_litigation_capacity_page
        Application::LitigationCapacityPage.new
      end

      def application_payment_page
        Application::PaymentPage.new
      end

      def application_permission_details_page
        Application::PermissionDetailsPage.new
      end

      def application_permission_sought_page
        Application::PermissionSoughtPage.new
      end

      def application_previous_proceedings_page
        Application::PreviousProceedingsPage.new
      end

      def application_receipt_email_check_page
        Application::ReceiptEmailCheckPage.new
      end

      def application_submission_page
        Application::SubmissionPage.new
      end

      def application_urgent_hearing_details_page
        Application::UrgentHearingDetailsPage.new
      end

      def application_urgent_hearing_page
        Application::UrgentHearingPage.new
      end

      def application_without_notice_details_page
        Application::WithoutNoticeDetailsPage.new
      end

      def application_without_notice_page
        Application::WithoutNoticePage.new
      end

      # Attending court pages
      def attending_court_intermediary_page
        AttendingCourt::IntermediaryPage.new
      end

      def attending_court_language_page
        AttendingCourt::LanguagePage.new
      end

      def attending_court_special_arrangements_page
        AttendingCourt::SpecialArrangementsPage.new
      end

      def attending_court_special_assistance_page
        AttendingCourt::SpecialAssistancePage.new
      end

      # Children pages
      def children_additional_details_page
        Children::AdditionalDetailsPage.new
      end

      def children_has_other_children_page
        Children::HasOtherChildrenPage.new
      end

      def children_names_page
        Children::NamesPage.new
      end

      def children_orders_page
        Children::OrdersPage.new
      end

      def children_parental_responsibility_page
        Children::ParentalResponsibilityPage.new
      end

      def children_personal_details_page
        Children::PersonalDetailsPage.new
      end

      def children_residence_page
        Children::ResidencePage.new
      end

      def children_special_guardianship_order_page
        Children::SpecialGuardianshipOrderPage.new
      end

      # Completion pages
      def completion_confirmation_page
        Completion::ConfirmationPage.new
      end

      def completion_what_next_page
        Completion::WhatNextPage.new
      end

      # Court orders pages
      def court_orders_details_page
        CourtOrders::DetailsPage.new
      end

      def court_orders_has_orders_page
        CourtOrders::HasOrdersPage.new
      end

      # International pages
      def international_jurisdiction_page
        International::JurisdictionPage.new
      end

      def international_request_page
        International::RequestPage.new
      end

      def international_resident_page
        International::ResidentPage.new
      end

      # MIAM pages
      def miam_acknowledgement_page
        Miam::AcknowledgementPage.new
      end

      def miam_attended_page
        Miam::AttendedPage.new
      end

      def miam_certification_exit_page
        Miam::CertificationExitPage.new
      end

      def miam_certification_page
        Miam::CertificationPage.new
      end

      # MIAM exemptions pages
      def miam_exemptions_adr_page
        MiamExemptions::AdrPage.new
      end

      def miam_exemptions_domestic_page
        MiamExemptions::DomesticPage.new
      end

      def miam_exemptions_exemption_details_page
        MiamExemptions::ExemptionDetailsPage.new
      end

      def miam_exemptions_exemption_reasons_page
        MiamExemptions::ExemptionReasonsPage.new
      end

      def miam_exemptions_exemption_upload_page
        MiamExemptions::ExemptionUploadPage.new
      end

      def miam_exemptions_exit_page
        MiamExemptions::ExitPage.new
      end

      def miam_exemptions_misc_page
        MiamExemptions::MiscPage.new
      end

      def miam_exemptions_protection_page
        MiamExemptions::ProtectionPage.new
      end

      def miam_exemptions_reasons_playback_page
        MiamExemptions::ReasonsPlaybackPage.new
      end

      def miam_exemptions_safety_playback_page
        MiamExemptions::SafetyPlaybackPage.new
      end

      def miam_exemptions_urgency_page
        MiamExemptions::UrgencyPage.new
      end

      # Opening pages
      def opening_child_protection_cases_page
        Opening::ChildProtectionCasesPage.new
      end

      def opening_child_protection_info_page
        Opening::ChildProtectionInfoPage.new
      end

      def opening_consent_order_page
        Opening::ConsentOrderPage.new
      end

      def opening_consent_order_sought_page
        Opening::ConsentOrderSoughtPage.new
      end

      def opening_consent_order_upload_page
        Opening::ConsentOrderUploadPage.new
      end

      def opening_continue_applications_page
        Opening::ContinueApplicationPage.new
      end

      def opening_error_but_continue_page
        Opening::ErrorButContinuePage.new
      end

      def opening_no_court_found_page
        Opening::NoCourtFoundPage.new
      end

      def opening_postcode_page
        Opening::PostcodePage.new
      end

      def opening_research_consent_page
        Opening::ResearchConsentPage.new
      end

      def opening_sign_in_or_create_account_page
        Opening::SignInOrCreateAccountPage.new
      end

      def opening_start_or_continue_page
        Opening::StartOrContinuePage.new
      end

      def opening_start_page
        Opening::StartPage.new
      end

      def opening_warning_page
        Opening::WarningPage.new
      end

      # Other children pages
      def other_children_names_page
        OtherChildren::NamesPage.new
      end

      def other_children_personal_details_page
        OtherChildren::PersonalDetailsPage.new
      end

      def other_party_address_details_page
        OtherParty::AddressDetailsPage.new
      end

      def other_party_children_cohabit_page
        OtherParty::ChildrenCohabitPage.new
      end

      def other_party_names_page
        OtherParty::NamesPage.new
      end

      def other_party_personal_details_page
        OtherParty::PersonalDetailsPage.new
      end

      def other_party_privacy_preferences_page
        OtherParty::PrivacyPreferencesPage.new
      end

      def other_party_refuge_page
        OtherParty::RefugePage.new
      end

      def other_party_relationship_page
        OtherParty::RelationshipPage.new
      end

      # Petition pages
      def petition_orders_page
        Petition::OrdersPage.new
      end

      def petition_playback_page
        Petition::PlaybackPage.new
      end

      def petition_protection_page
        Petition::ProtectionPage.new
      end

      # Respondent pages
      def respondent_address_details_page
        Respondent::AddressDetailsPage.new
      end

      def respondent_contact_details_page
        Respondent::ContactDetailsPage.new
      end

      def respondent_has_other_parties_page
        Respondent::HasOtherPartiesPage.new
      end

      def respondent_names_page
        Respondent::NamesPage.new
      end

      def respondent_personal_details_page
        Respondent::PersonalDetailsPage.new
      end

      def respondent_relationship_page
        Respondent::RelationshipPage.new
      end

      # Safety questions pages
      def safety_questions_children_abuse_page
        SafetyQuestions::ChildrenAbusePage.new
      end

      def safety_questions_domestic_abuse_page
        SafetyQuestions::DomesticAbusePage.new
      end

      def safety_questions_other_abuse_page
        SafetyQuestions::OtherAbusePage.new
      end

      def safety_questions_risk_of_abduction_page
        SafetyQuestions::RiskOfAbductionPage.new
      end

      def safety_questions_start_page
        SafetyQuestions::StartPage.new
      end

      def safety_questions_substance_abuse_page
        SafetyQuestions::SubstanceAbusePage.new
      end

      # Solicitor pages
      def solicitor_address_details_page
        Solicitor::AddressDetailsPage.new
      end

      def solicitor_contact_details_page
        Solicitor::ContactDetailsPage.new
      end

      def solicitor_personal_details_page
        Solicitor::PersonalDetailsPage.new
      end

      # @return [C100::Test::PageObjects::AnyPage] The special 'any' page that can access
      #   elements that are common to all
      def any_page
        AnyPage.new
      end
    end
  end
end

World(C100::Test::PageObjects)
