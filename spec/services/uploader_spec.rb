require 'spec_helper'

RSpec.describe Uploader do

  let(:collection_ref) { 'collection_ref' }
  let(:document_key) { 'document_key' }
  let(:filename) { 'filename' }
  let(:data) { 'data' }

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

  describe '.add_file' do
    it 'calls Uploader::Addfile' do
      expect_any_instance_of(Uploader::AddFile).to receive(:call)
      described_class.add_file(
        collection_ref: collection_ref,
        document_key: document_key,
        filename: filename,
        data: data
      )
    end
  end

  describe '.list_files' do
    it 'calls Uploader::ListFiles' do
      expect_any_instance_of(Uploader::ListFiles).to receive(:call)
      described_class.list_files(
        collection_ref: collection_ref,
        document_key: document_key
      )
    end
  end

  describe '.delete_file' do
    it 'calls Uploader::DeleteFile' do
      expect_any_instance_of(Uploader::DeleteFile).to receive(:call)
      described_class.delete_file(
        collection_ref: collection_ref,
        document_key: document_key,
        filename: filename
      )
    end
  end

  describe '.get_file' do
    it 'calls Uploader::GetFile' do
      expect_any_instance_of(Uploader::GetFile).to receive(:call)
      described_class.get_file(
        collection_ref: collection_ref,
        document_key: document_key,
        filename: filename,
        data: data
      )
    end
  end

end
