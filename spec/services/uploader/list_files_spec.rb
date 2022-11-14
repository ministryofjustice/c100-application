require 'spec_helper'

RSpec.describe Uploader::ListFiles do

  subject { described_class.new(params).call }

  before do
    allow_any_instance_of(Aws::S3::Client).to receive(:list_objects).
      and_return([])
    allow(ENV).to receive(:fetch).with('AWS_BUCKET', '').and_return(bucket)
  end

  let(:bucket) { 'bucket' }
  let(:collection_ref) { 'collection_ref' }
  let(:document_key) { 'document_key' }

  let(:params) { {
    collection_ref: collection_ref,
    document_key: document_key
  } }

  describe '.call' do

    it 'calls aws client' do
      expect_any_instance_of(Aws::S3::Client).to receive(:list_objects).
        with({
          bucket:bucket,
          prefix: "#{collection_ref}/#{document_key}/"
        })
      subject
    end

  end

end