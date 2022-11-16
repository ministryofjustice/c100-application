require 'spec_helper'

RSpec.describe Uploader do

  let(:collection_ref) { 'collection_ref' }
  let(:document_key) { 'document_key' }
  let(:filename) { 'filename' }
  let(:data) { 'data' }

  describe '.add_file' do
    it 'calls Uploader::Addfile' do
      expect_any_instance_of(Uploader::AddFile).to receive(:call)
      described_class.add_file({
        collection_ref: collection_ref,
        document_key: document_key,
        filename: filename,
        data: data
      })
    end
  end

  describe '.list_files' do
    it 'calls Uploader::ListFiles' do
      expect_any_instance_of(Uploader::ListFiles).to receive(:call)
      described_class.list_files({
        collection_ref: collection_ref,
        document_key: document_key
      })
    end
  end

  describe '.delete_file' do
    it 'calls Uploader::DeleteFile' do
      expect_any_instance_of(Uploader::DeleteFile).to receive(:call)
      described_class.delete_file({
        collection_ref: collection_ref,
        document_key: document_key,
        filename: filename
      })
    end
  end

  describe '.get_file' do
    it 'calls Uploader::GetFile' do
      expect_any_instance_of(Uploader::GetFile).to receive(:call)
      described_class.get_file({
        collection_ref: collection_ref,
        document_key: document_key,
        filename: filename,
        data: data
      })
    end
  end

end
