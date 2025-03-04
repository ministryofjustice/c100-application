Dir[File.join(Rails.root, 'lib', 'extensions', '*.rb')].each(&method(:require))

class Array
  include ArrayExtension
end

class String
  include StringExtension
end

module ActiveRecord
  module Querying
    include RelationExtension
  end
end
