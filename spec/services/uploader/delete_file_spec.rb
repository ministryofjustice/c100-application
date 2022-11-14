require 'spec_helper'

RSpec.describe Uploader::DeleteFile do

  subject { described_class.new(params).call }

  before do
    allow_any_instance_of(Aws::S3::Client).to receive(:delete_object)
    allow(ENV).to receive(:fetch).with('AWS_BUCKET', '').and_return(bucket)
  end

  let(:bucket) { 'bucket' }
  let(:collection_ref) { 'collection_ref' }
  let(:document_key) { 'document_key' }
  let(:filename) { 'filename.doc' }

  let(:params) { {
    collection_ref: collection_ref,
    document_key: document_key,
    filename: filename
  } }

  describe '.call' do

    it 'calls aws client' do
      expect_any_instance_of(Aws::S3::Client).to receive(:delete_object).
        with({
          bucket:bucket,
          key: "#{collection_ref}/#{document_key}/#{filename}"
        })
      subject
    end

  end

end