module FeeIncrease
  extend ActiveSupport::Concern

  def self.changes_apply?
    Time.now >= Rails.application.config.fee_increase_date
  end
end
