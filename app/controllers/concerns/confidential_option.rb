module ConfidentialOption
  extend ActiveSupport::Concern

  def self.changes_apply?
    Time.zone.now.in_time_zone('London') >= Rails.application.config.confidential_option_date
    true
  end
end
