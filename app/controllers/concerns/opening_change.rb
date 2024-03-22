module OpeningChange
  extend ActiveSupport::Concern

  def self.changes_apply?
    ENV["OPENING_CHANGE"] == "true"
  end
end
