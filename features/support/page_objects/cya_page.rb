class CYAPage < BasePage
  set_url '/steps/application/check_your_answers'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Check your answers'
  end

  section :opening_questions, 'dl#opening_questions' do
    section :children_postcode, CYASummaryListRow, '#children_postcode'
    section :consent_order_application, CYASummaryListRow, '#consent_order_application'
    section :child_protection_cases, CYASummaryListRow, '#child_protection_cases'
  end

  section :miam_exemptions, 'dl#miam_exemptions' do
    section :exemption_details, CYASummaryListRow, '#exemption_details'
    section :exemption, CYASummaryListRow, '#exemption'
  end

  section :safety_concerns, 'dl#safety_concerns' do
    section :risk_of_abduction, CYASummaryListRow, '#risk_of_abduction'
    section :children_abuse, CYASummaryListRow, '#children_abuse'
    section :domestic_abuse, CYASummaryListRow, '#domestic_abuse'
    section :other_abuse, CYASummaryListRow, '#other_abuse'
    section :substance_abuse, CYASummaryListRow, '.app-cya--answers-group#substance_abuse' do
      section :substance_abuse_details, CYASummaryListRow, '#substance_abuse'
      def answer
        substance_abuse_details.answer
      end
    end
  end

  section :nature_of_application, 'dl#nature_of_application' do
    section :child_arrangements_orders, CYASummaryListRow, '#child_arrangements_orders'
  end

  section :alternatives, 'dl#alternatives' do
    section :alternative_negotiation_tools, CYASummaryListRow, '#alternative_negotiation_tools'
    section :alternative_mediation, CYASummaryListRow, '#alternative_mediation'
    section :alternative_lawyer_negotiation, CYASummaryListRow, '#alternative_lawyer_negotiation'
    section :alternative_collaborative_law, CYASummaryListRow, '#alternative_collaborative_law'
  end

  section :children_details, 'dl#children_details' do
    elements :children, 'h3'
    sections :full_name, CYASummaryListRow, '#person_full_name'
    sections :child_orders, CYASummaryListRow, '#child_orders'
    sections :special_guardianship_order, CYASummaryListRow, '#special_guardianship_order'
    sections :parental_responsibility, CYASummaryListRow, '#parental_responsibility'
    sections :personal_details, CYASummaryListRow, '#person_personal_details' do
      section :date_of_birth, CYASummaryListRow, '#person_dob'
      section :person_sex, CYASummaryListRow, '#person_sex'
      def dob
        date_of_birth.answer
      end

      def sex
        person_sex.answer
      end
    end
    sections :child_orders, CYASummaryListRow, '#child_orders' do
      elements :order, 'li'
      def answer
        order.map(&:text).join(', ')
      end
    end
  end

  section :children_further_information, 'dl#children_further_information' do
    section :known_to_authorities, CYASummaryListRow, '#children_known_to_authorities'
    section :protection_plan, CYASummaryListRow, '#children_protection_plan'
    section :has_other_children, CYASummaryListRow, '#has_other_children'
  end


end