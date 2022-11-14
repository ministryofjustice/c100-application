require 'spec_helper'

RSpec.describe Uploader::ApiClient do

  subject { described_class.new }

  describe '.initialize' do
    it 'initialises aws client' do
      expect(Aws::S3::Client).to receive(:new)
      subject
    end
  end

end