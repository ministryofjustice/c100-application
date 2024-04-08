require 'spec_helper'

RSpec.describe Uploader::ApiClient do

  before do
    allow(ENV).to receive(:[])
    allow(ENV).to receive(:[]).with("AWS_S3_REGION").and_return('eu-west-2')
    allow(ENV).to receive(:[]).with("AWS_ROLE_ARN").and_return('test')
    allow(ENV).to receive(:[]).with("AWS_WEB_IDENTITY_TOKEN_FILE").and_return('test2')
    stub_request(:post, "https://sts.eu-west-2.amazonaws.com/").to_return(status: 200, body: "", headers: {})
    allow(Aws::AssumeRoleWebIdentityCredentials).to receive(:new).with(
      role_arn: "test",
      web_identity_token_file: "test2"
    )
  end

  subject { described_class.new }

  describe '.initialize' do
    it 'initialises aws client' do
      expect(Aws::S3::Client).to receive(:new)
      subject
    end
  end

end