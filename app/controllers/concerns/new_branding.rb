module NewBranding
  extend ActiveSupport::Concern

  def self.changes_apply?
    Time.zone.now.in_time_zone('London') >= Rails.application.config.new_branding_date
  end
end
