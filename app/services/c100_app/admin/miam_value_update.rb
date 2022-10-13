module C100App
  module Admin
    class MiamValueUpdate
      def update_values
        {adr: %w[previous_attendance ongoing_attendance existing_proceedings_attendance
                 previous_exemption existing_proceedings_exemption adr_none],
         domestic: %w[right_to_remain financial_abuse domestic_none],
         misc: %w[no_respondent_address without_notice access_prohibited
                  non_resident applicant_under_age],
         protection: %w[authority_enquiring authority_protection_order protection_none],
         urgency: %w[risk_applicant unreasonable_hardship risk_children
                     risk_unlawful_removal_retention miscarriage_justice irretrievable_problems
                     international_proceedings urgency_none] }
      end

      def undo_values
        {adr: %w[misc_previous_attendance misc_ongoing_attendance
                 misc_existing_proceedings_attendance misc_previous_exemption
                 misc_existing_proceedings_exemption misc_adr_none],
         domestic: %w[misc_right_to_remain misc_financial_abuse misc_domestic_none],
         misc: %w[misc_no_respondent_address misc_without_notice misc_access_prohibited
                  misc_non_resident misc_applicant_under_age],
         protection: %w[misc_authority_enquiring misc_authority_protection_order
                        misc_protection_none],
         urgency: %w[misc_risk_applicant misc_unreasonable_hardship misc_risk_children
                     misc_risk_unlawful_removal_retention misc_miscarriage_justice
                     misc_irretrievable_problems misc_international_proceedings misc_urgency_none] }
      end

      def update_miam_values!
        update_values.each do |attribute_key, attribute_array|
          id = MiamExemption.pluck(:id)
          column = MiamExemption.pluck(attribute_key)
          count = 0
          new_column = []
          column.each do |set|
            set.each do |entry|
              new_column << if attribute_array.include?(entry)
                              "misc_#{entry}"
                            else
                              entry
                            end
            end
            new_column.flatten!
            MiamExemption.find(id[count]).update(attribute_key => new_column)
            new_column = []
            count += 1
          end
        end
      end

      def undo_miam_migrate!
        undo_values.each do |attribute_key, attribute_array|
          id = MiamExemption.pluck(:id)
          column = MiamExemption.pluck(attribute_key)
          count = 0
          new_column = []
          column.each do |set|
            set.each do |entry|
              new_column << if attribute_array.include?(entry)
                              entry.delete_prefix("misc_")
                            else
                              entry
                            end
            end
            new_column.flatten!
            MiamExemption.find(id[count]).update(attribute_key => new_column)
            new_column = []
            count += 1
          end
        end
      end
    end
  end
end
