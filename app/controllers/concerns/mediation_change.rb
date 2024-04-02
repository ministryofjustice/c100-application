module MediationChange
  extend ActiveSupport::Concern

  def self.changes_apply?(c100_application)
    c100_application.created_at >= DateTime.parse(ENV["MEDIATION_DATE"])
  end
end
