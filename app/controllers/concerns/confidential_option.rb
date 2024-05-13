module ConfidentialOption
  extend ActiveSupport::Concern

  def self.changes_apply?
    Time.now >= Rails.application.config.confidential_option_date
  end
end
