class CYAPage < BasePage
  set_url '/steps/application/check_your_answers'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Check your answers'
    element :submit_application, 'button', text: 'Submit application'
    element :save_and_come_back, 'button', text: 'Save and come back later'
  end

  section :opening_questions, CYAGroup, 'dl#opening_questions' do
    row :children_postcode, '#children_postcode'
    row :consent_order_application, '#consent_order_application'
    row :child_protection_cases, '#child_protection_cases'
  end

  section :mediation_voucher, CYAGroup, 'dl#mediation_voucher' do
    row :voucher_scheme, '#mediation_voucher_scheme'
  end

  section :miam_requirement, CYAGroup, 'dl#miam_requirement' do
    row :miam_attended, '#miam_attended'
    row :miam_exemption_claim, '#miam_exemption_claim'
    row :miam_certification, '#miam_certification'
    row :miam_certificate, '#miam_certificate'
  end

  section :miam_exemptions, CYAGroup, 'dl#miam_exemptions' do
    row :exemptions_misc, '#miam_exemptions_misc'
    row :exemption_details, '#exemption_details'
    row :attach_evidence, '#attach_evidence'
    row :exemption, '#exemption'
  end

  section :safety_concerns, CYAGroup, 'dl#safety_concerns' do
    row :risk_of_abduction, '#risk_of_abduction'
    row :children_abuse, '#children_abuse'
    row :domestic_abuse, '#domestic_abuse'
    row :other_abuse, '#other_abuse'
    section :substance_abuse, CYAGroup, '.app-cya--answers-group#substance_abuse' do
      row :details, '#substance_abuse'
      row :additional_details, '#substance_abuse_details'
    end
  end

  section :abduction, CYAGroup, 'dl#abduction' do
  end

  section :children_abuse_details, CYAGroup, 'dl#children_abuse_details' do
    row :abuse_sexual, '#abuse_sexual'
    row :abuse_physical, '#abuse_physical'
    row :abuse_financial, '#abuse_financial'
    row :abuse_psychological, '#abuse_psychological'
    row :abuse_emotional, '#abuse_emotional'
    row :abuse_other, '#abuse_other'
  end

  section :applicant_abuse_details, CYAGroup, 'dl#applicant_abuse_details' do
    row :abuse_sexual, '#abuse_sexual'
    row :abuse_physical, '#abuse_physical'
    row :abuse_financial, '#abuse_financial'
    row :abuse_psychological, '#abuse_psychological'
    row :abuse_emotional, '#abuse_emotional'
    row :abuse_other, '#abuse_other'
  end

  section :nature_of_application, CYAGroup, 'dl#nature_of_application' do
    elements :child_arrangements_orders, 'li'
    def answer
      child_arrangements_orders.map(&:text).join(', ')
    end
  end

  section :alternatives, CYAGroup, 'dl#alternatives' do
    row :alternative_negotiation_tools, '#alternative_negotiation_tools'
    row :alternative_mediation, '#alternative_mediation'
    row :alternative_lawyer_negotiation, '#alternative_lawyer_negotiation'
    row :alternative_collaborative_law, '#alternative_collaborative_law'
  end

  section :children_details, CYAGroup, 'dl#children_details' do
    elements :children, 'h3'
    rows :full_name, '#person_full_name'
    rows :special_guardianship_order, '#special_guardianship_order'
    rows :parental_responsibility, '#parental_responsibility'
    rows :personal_details, CYAPersonalDetails, '#person_personal_details'
    rows :child_orders, '#child_orders' do
      elements :orders, 'li'
      def answer
        orders.map(&:text).join(', ')
      end
    end
  end

  section :children_further_info, CYAGroup, 'dl#children_further_information' do
    row :known_to_authorities, '#children_known_to_authorities'
    row :protection_plan, '#children_protection_plan'
    row :has_other_children, '#has_other_children'
  end

  section :applicants_details, CYAGroup, 'dl#applicants_details' do
    elements :applicants, 'h3'
    rows :full_name, '#person_full_name'
    rows :privacy_known, '#person_privacy_known'
    rows :contact_details_private, '#person_contact_details_private'
    rows :refuge, '#refuge'
    rows :personal_details, CYAPersonalDetails, '#person_personal_details'
    rows :relationship_to_child, '#relationship_to_child'
    
    sections :address_details, CYAGroup, '#person_address_details' do
      row :address, '#person_address'
      row :lived_at_5_years, '#person_residence_requirement_met'
    end

    sections :contact_details, CYAGroup, '#person_contact_details' do
      row :email_provided, '#person_email_provided'
      row :email, '#person_email'
      row :phone_number, '#person_phone_number'
      row :voicemail_consent, '#person_voicemail_consent'
    end
  end

  section :solicitor_details, CYAGroup, 'dl#solicitor_details' do
    row :has_solicitor, '#has_solicitor'
    section :personal_details, CYAGroup, '#solicitor_personal_details' do
      row :full_name, '#solicitor_full_name'
      row :firm_name, '#solicitor_firm_name'
    end
    section :address_details, CYAGroup, '#solicitor_address_details' do
      row :address, '#solicitor_address'
    end
    section :contact_details, CYAGroup, '#solicitor_contact_details' do
      row :email, '#solicitor_email'
      row :phone_number, '#solicitor_phone_number'
      row :dx_number, '#solicitor_dx_number'
    end
  end

  section :respondents_details, CYAGroup, 'dl#respondents_details' do
    elements :respondents, 'h3'
    rows :full_name, '#person_full_name'
    rows :personal_details, CYAPersonalDetails, '#person_personal_details'
    rows :relationship_to_child, '#relationship_to_child'
    sections :address_details, CYAGroup, '#person_address_details' do
      row :address, '#person_address'
      row :lived_at_5_years, '#person_residence_requirement_met'
    end
    sections :contact_details, CYAGroup, '#person_contact_details' do
      row :email, '#person_email'
      row :phone_number, '#person_phone_number'
    end
  end

  section :other_parties_details, CYAGroup, 'dl#other_parties_details' do
    row :has_other_parties, '#has_other_parties'
    elements :other_parties, 'h3'
    rows :full_name, '#person_full_name'
    rows :personal_details, CYAPersonalDetails, '#person_personal_details'
    rows :relationship_to_child, '#relationship_to_child'
    sections :address_details, CYAGroup, '#person_address_details' do
      row :address, '#person_address'
    end
  end

  section :children_residence, CYAGroup, 'dl#children_residence' do
    sections :child, CYASummaryListRow, '#child_residence' do
      def child_name
        key.text
      end
      
      def residence
        value.text
      end
    end
  end

  section :other_court_cases, CYAGroup, 'dl#other_court_cases' do
    row :has_other_court_cases, '#has_other_court_cases'
    section :details, CYAGroup, '#other_court_cases_details' do
      row :children_names, '#court_proceeding_children_names'
      row :court_name, '#court_proceeding_court_name'
      row :proceedings_date, '#court_proceeding_proceedings_date'
      row :order_types, '#court_proceeding_order_types'
      row :previous_details, '#court_proceeding_previous_details'
    end
  end

  section :application_reasons, CYAGroup, 'dl#application_reasons' do
    row :details, '#application_details'
    section :has_existing_court_order, CYAGroup, '.app-cya--answers-group#existing_court_order' do
      row :details, '#existing_court_order'
      row :case_number, '#court_order_case_number'
      row :expiry_date, '#court_order_expiry_date'
    end
    row :existing_court_order_uploadable, '#existing_court_order_uploadable'
    row :existing_court_order_upload, '#existing_court_order_upload'
  end

  section :urgent_hearing, CYAGroup, 'dl#urgent_hearing' do
    row :needs_urgent_hearing, '#urgent_hearing'
  end

  section :without_notice_hearing, CYAGroup, 'dl#without_notice_hearing' do
    row :asking_for_without_notice_hearing, '#without_notice_hearing'
    row :details, '#without_notice_details'
  end

  section :international_info, CYAGroup, 'dl#international_element' do
    section :international_resident, CYAGroup, '.app-cya--answers-group#international_resident' do
      row :details, '#international_resident'
      row :additional_details, '#international_resident_details'
    end
    section :international_jurisdiction, CYAGroup, '.app-cya--answers-group#international_jurisdiction' do
      row :can_apply_outside_en_cy, '#international_jurisdiction'
      row :details, '#international_jurisdiction_details'
    end
    row :international_request, CYANestedSummaryRow, '.app-cya--answers-group#international_request'
  end

  section :litigation_capacity, CYAGroup, 'dl#litigation_capacity' do
    row :reduced_litigation_capacity, '#reduced_litigation_capacity'
  end

  section :attending_court, CYAGroup, 'dl#attending_court' do
    row :requires_intermediary_help, '#intermediary_help'
    row :intermediary_help_details, '#intermediary_help_details'
    section :language_requirements, CYAGroup, '.app-cya--answers-group#language_interpreter' do
      row :interpreter, '#language_interpreter'
      row :sign_language_interpreter, '#sign_language_interpreter'
      row :welsh_language, '#welsh_language'
    end
    section :safety_arrangements, CYAGroup, '.app-cya--answers-group#special_arrangements' do
      row :details, '#special_arrangements'
      elements :arrangements, 'li'
    end
    section :special_assistance, CYAGroup, '.app-cya--answers-group#special_assistance' do
      row :details, '#special_assistance'
      row :additional_details, '#special_assistance_details'
    end
  end

  section :submission, CYAGroup, 'dl#submission' do
    section :email, CYANestedSummaryRow, '.app-cya--answers-group#submission_type'
  end

  section :payment, CYAGroup, 'dl#payment' do
    section :payment_method, CYAGroup, '.app-cya--answers-group#payment_type' do
      row :type, '#payment_type'
      row :hwf_ref_no, '#hwf_reference_number'
    end
  end

  section :statement_of_truth, '#cya-declaration-box' do
    element :applicant_confirmation, 
      "input[name='steps_application_declaration_form[declaration_confirmation]'][value='applicant']", visible: false
    element :representative_confirmation, 
      "input[name='steps_application_declaration_form[declaration_confirmation]'][value='representative']", visible: false
    element :signee_name, '#steps-application-declaration-form-declaration-signee-field'
    element :applicant_capacity,
      "input[name='steps_application_declaration_form[declaration_signee_capacity]'][value='applicant']", visible: false
    element :representative_capacity,
      "input[name='steps_application_declaration_form[declaration_signee_capacity]'][value='representative']", visible: false
  end

  def complete_statement_of_truth_as_applicant(name)
    statement_of_truth.applicant_confirmation.click
    statement_of_truth.signee_name.set name
  end

  def complete_declaration_as_applicant
    statement_of_truth.applicant_capacity.click
  end

  def complete_statement_of_truth_as_representative(name)
    statement_of_truth.representative_confirmation.click
    statement_of_truth.signee_name.set name
  end

  def complete_declaration_as_representative
    statement_of_truth.representative_capacity.click
  end
end
