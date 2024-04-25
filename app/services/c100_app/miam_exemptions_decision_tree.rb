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
        MediationChange.changes_apply?(c100_application) ? reasons_or_exit_page : playback_or_exit_page
      when :exemption_details
        show(:reasons_playback)
      when :exemption_reasons
        upload_or_exit_page
      when :exemption_upload
        edit(:exemption_details)
      else
        raise InvalidStep, "Invalid step '#{as || step_params}'"
      end
    end

    private

    def reasons_or_exit_page
      if has_miam_exemptions?
        if has_only_misc_exemptions?
          show(:reasons_playback)
        else
          edit(:exemption_reasons)
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

    def upload_or_exit_page
      if c100_application.attach_evidence == "yes"
        edit(:exemption_upload)
      else
        playback_or_exit_page
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
  end
end
