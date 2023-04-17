module StartingPointStep
  extend ActiveSupport::Concern

  private

  def current_c100_application
    # Only the step including this concern should create a C100 application
    # if there isn't one in the session - because it's the first
    super || initialize_c100_application
  end
end
