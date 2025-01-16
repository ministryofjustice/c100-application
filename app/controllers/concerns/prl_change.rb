module PrlChange
  extend ActiveSupport::Concern

  def self.changes_apply?
    Time.zone.now.in_time_zone('London') >= Rails.application.config.prl_opening_date
  end
end
