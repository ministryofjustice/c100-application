module Summary
  module Helpers
    def additional_data(hash)
      { type: self.class.name.demodulize }.merge(hash)
    end
  end
end
