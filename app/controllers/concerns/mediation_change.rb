module MediationChange
  extend ActiveSupport::Concern

  def self.changes_apply?(c100_application)
    c100_application.created_at >= Rails.application.config.mediation_change_date
  end
end
