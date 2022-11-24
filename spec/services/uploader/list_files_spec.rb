require 'spec_helper'

RSpec.describe Uploader::ListFiles do

  subject { described_class.new(params).call }

  before do
    allow_any_instance_of(Aws::S3::Client).to receive(:list_objects).
      and_return(['123'])
    allow(ENV).to receive(:fetch).with('AWS_S3_REGION').and_return('eu-west-2')
    allow(ENV).to receive(:fetch).with('AWS_S3_ACCESS_KEY_ID')
    allow(ENV).to receive(:fetch).with('AWS_S3_SECRET_ACCESS_KEY')
    allow(ENV).to receive(:fetch).with('AWS_S3_BUCKET', '').and_return(bucket)
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

    context 'when no files found' do
      before do
        allow_any_instance_of(Aws::S3::Client).to receive(:list_objects).
          and_return([])
      end
      it 'logs and raises error' do
        allow(Rails).to receive_message_chain(:logger, :tagged).and_yield
        expect(Rails).to receive_message_chain(:logger, :warn)
        subject
      end
    end


    context 'when AWS raises error' do
      before do
        allow_any_instance_of(Aws::S3::Client).to receive(:list_objects).
          and_raise(StandardError)
      end

      it 'logs and raises error' do
        allow(Rails).to receive_message_chain(:logger, :tagged).and_yield
        expect(Rails).to receive_message_chain(:logger, :warn)

        expect { subject }.to raise_error(Uploader::UploaderError)
      end
    end

  end

end