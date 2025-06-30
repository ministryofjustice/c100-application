module PrlWolverhamptonRollout
  extend ActiveSupport::Concern

  def self.changes_apply?
    Time.zone.now.in_time_zone('London') >= Rails.application.config.prl_wolverhampton_date
  end
end
