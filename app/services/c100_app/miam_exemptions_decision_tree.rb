module C100App
  class MiamExemptionsDecisionTree < BaseDecisionTree
    def destination
      return next_step if next_step

      case step_name
      when :domestic
        edit(:protection)
      when :protection
        edit(:urgency)
      when :urgency
        edit(:adr)
      when :adr
        edit(:misc)
      when :misc
        reasons_or_exit_page
      when :exemption_details
        show(:reasons_playback)
      when :exemption_reasons
        upload_or_details
      when :exemption_upload
        edit(:exemption_details)
      else
        raise InvalidStep, "Invalid step '#{as || step_params}'"
      end
    end

    private

    def reasons_or_exit_page
      if has_miam_exemptions?
        if has_misc_skip_exemptions?
          edit(:exemption_details)
        elsif has_domestic_exemptions? || has_only_misc_exemptions?
          edit(:exemption_reasons)
        else
          show(:reasons_playback)
        end
      else
        show(:exit_page)
      end
    end

    def playback_or_exit_page
      if has_miam_exemptions?
        show(:reasons_playback)
      else
        show(:exit_page)
      end
    end

    def upload_or_details
      if c100_application.attach_evidence == "yes"
        edit(:exemption_upload)
      else
        edit(:exemption_details)
      end
    end

    def has_miam_exemptions?
      MiamExemptionsPresenter.new(
        c100_application.miam_exemption
      ).exemptions.any?
    end

    def has_only_misc_exemptions?
      groups = [:domestic, :protection, :urgency, :adr]
      exemptions = c100_application.miam_exemption
      groups.each do |group|
        exemption = exemptions.send(group)
        return false unless exemption.include? "misc_#{group}_none"
      end
      true
    end

    def has_misc_skip_exemptions?
      exemptions = c100_application.miam_exemption.send(:misc)
      return true if %w[misc_access misc_access2 misc_access3].any? { |misc| exemptions.include? misc }
      false
    end

    def has_domestic_exemptions?
      exemptions = c100_application.miam_exemption
      exemptions.domestic.exclude? "misc_domestic_none"
    end
  end
end
