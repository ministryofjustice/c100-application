require 'spec_helper'

RSpec.describe Uploader::GetFile do

  subject { described_class.new(**params).call }

  before do
    allow(Uploader::ListFiles).to receive(:new).
      and_return(
        double('Uploader::ListFiles', call:
          double(contents: [double('file', key: key)]))
        )
    allow(ENV).to receive(:[])
    allow(ENV).to receive(:fetch).with('AWS_S3_BUCKET', '').and_return(bucket)
    allow(ENV).to receive(:[]).with("AWS_S3_REGION").and_return('eu-west-2')
    allow(ENV).to receive(:[]).with("AWS_ROLE_ARN").and_return('test')
    allow(ENV).to receive(:[]).with("AWS_WEB_IDENTITY_TOKEN_FILE").and_return('test2')
    stub_request(:post, "https://sts.eu-west-2.amazonaws.com/").to_return(status: 200, body: "", headers: {})
    allow(Aws::AssumeRoleWebIdentityCredentials).to receive(:new).with(
      role_arn: "test",
      web_identity_token_file: "test2"
    )
  end

  let(:bucket) { 'bucket' }
  let(:collection_ref) { 'collection_ref' }
  let(:document_key) { 'document_key' }
  let(:filename) { 'filename.doc' }
  let(:key) { '123' }

  let(:params) { {
    collection_ref: collection_ref,
    document_key: document_key
  } }

  describe '.call' do

    it 'calls list files' do
      expect(Uploader::ListFiles).to receive(:new).
        with(**params)
      subject
    end

    it 'gets first file and puts it into a file' do
      expect(Uploader::File).to receive(:new).
        with(key)
      subject
    end

  end

end