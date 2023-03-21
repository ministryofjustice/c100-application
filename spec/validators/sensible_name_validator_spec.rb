require 'rails_helper'

class TestModel
  include ActiveModel::Validations

  def initialize(attributes = {})
    @attributes = attributes
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end
end

class TestName < TestModel
  validates :first_name, sensible_name: true
end

RSpec.describe SensibleNameValidator do

  it "should be valid for an input with no special characters" do
    expect(TestName.new(:first_name => 'name')).to be_valid

  end

  it 'is not valid for an input with special characters' do
    expect(TestName.new(:first_name => 'qwe<@£$%^&*(')).to_not be_valid

  end

end
