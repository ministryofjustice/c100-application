require 'spec_helper'

RSpec.describe Uploader::File do

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

  let(:filepath) { 'deb757fc-f06d-4233-b260-11edcb7416f3/draft_consent_order/letter.jpg' }

  it 'gets the name' do
    file = described_class.new(filepath)
    expect(file.name).to eq 'letter.jpg'
  end

  describe '.==' do
    it 'compares key values' do
      assert(Uploader::File.new('123') == Uploader::File.new('123'))
      assert(!(Uploader::File.new('123') == Uploader::File.new('456')))
    end
  end

  describe '.hash' do
    it 'hashes the key' do
      expect(Uploader::File.new('123').hash).to eq('123'.hash)
    end
  end

end