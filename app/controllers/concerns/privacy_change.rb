module PrivacyChange
  extend ActiveSupport::Concern

  def self.changes_apply?
    ENV["PRIVACY_CHANGE"] == "true"
  end
end
