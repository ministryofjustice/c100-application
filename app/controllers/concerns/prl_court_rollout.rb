module PrlCourtRollout
  extend ActiveSupport::Concern

  def self.changes_apply?
    Time.zone.now.in_time_zone('London') >= Rails.application.config.prl_court_rollout
  end
end
