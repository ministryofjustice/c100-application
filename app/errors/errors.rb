module Errors
  class InvalidSession < StandardError; end
  class ApplicationNotFound < StandardError; end
  class ApplicationCompleted < StandardError; end
  class ApplicationScreening < StandardError; end
end
