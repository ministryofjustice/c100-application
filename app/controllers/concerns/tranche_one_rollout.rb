module TrancheOneRollout
  extend ActiveSupport::Concern

  def self.changes_apply?
    Rails.application.config.tranche_one_rollout
  end
end
