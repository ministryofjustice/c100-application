require 'spec_helper'

RSpec.describe Uploader::DeleteFile do

  subject { described_class.new(params).call }

  before do
    allow_any_instance_of(Aws::S3::Client).to receive(:delete_object)
    allow(ENV).to receive(:fetch).with('AWS_S3_BUCKET', '').and_return(bucket)
    allow(Rails).to receive_message_chain(:logger, :tagged).and_yield
    allow(Rails).to receive_message_chain(:logger, :info)
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

    context 'when AWS raises error' do
      before do
        allow_any_instance_of(Aws::S3::Client).to receive(:delete_object).
          and_raise(StandardError)
      end

      it 'logs and raises error' do
        expect(Rails).to receive_message_chain(:logger, :warn)

        expect { subject }.to raise_error(Uploader::UploaderError)
      end
    end

  end

end