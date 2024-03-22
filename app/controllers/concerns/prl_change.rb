module PrlChange
  extend ActiveSupport::Concern

  def self.changes_apply?
    ENV["PRL_OPENING"] == "true"
  end
end
