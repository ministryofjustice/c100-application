module PresentCollection
  # :nocov:
  def present_each(presenter)
    each do |obj|
      yield presenter.new(obj)
    end
  end
  # :nocov:
end

module ActiveRecord
  class Relation
    include PresentCollection
  end
end

class Array
  include PresentCollection
end
