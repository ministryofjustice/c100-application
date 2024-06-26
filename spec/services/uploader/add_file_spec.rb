require 'spec_helper'

RSpec.describe Uploader::AddFile do

  subject { described_class.new(**params).call }

  before do
    allow_any_instance_of(Aws::S3::Client).to receive(:put_object)
    allow(ENV).to receive(:[])
    allow(ENV).to receive(:fetch).with('SKIP_VIRUS_CHECK', '').and_return('')
    allow(ENV).to receive(:fetch).with('AWS_S3_BUCKET', '').and_return(bucket)
    allow(ENV).to receive(:[]).with('AWS_S3_REGION').and_return('eu-west-2')
    allow(ENV).to receive(:[]).with('AWS_ROLE_ARN').and_return('test')
    allow(ENV).to receive(:[]).with("AWS_WEB_IDENTITY_TOKEN_FILE").and_return('test2')
    allow(Clamby).to receive(:safe?).and_return(true)
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
  let(:data) { 'data' }

  let(:params) { {
    collection_ref: collection_ref,
    document_key: document_key,
    filename: filename,
    data: data
  } }

  describe '.upload' do
    it 'calls aws client' do
      expect_any_instance_of(Aws::S3::Client).to receive(:put_object).
        with({
          body: data,
          bucket:bucket,
          key: "#{collection_ref}/#{document_key}/#{filename}"
        })
      subject
    end

    context 'when AWS raises error' do
      before do
        allow_any_instance_of(Aws::S3::Client).to receive(:put_object).
          and_raise(StandardError)
      end

      it 'logs and raises error' do
        allow(Rails).to receive_message_chain(:logger, :tagged).and_yield
        allow(Rails).to receive_message_chain(:logger, :warn)

        expect { subject }.to raise_error(Uploader::UploaderError)
      end

    end

  end

  describe '.scan_file' do
    context 'with a virus' do
      before do
        expect(Clamby).to receive(:safe?).and_return(false)
      end
      it 'detects viruses' do
        expect{ subject }.to raise_error(Uploader::InfectedFileError)
      end
    end

    context 'without a virus' do
      before do
        expect(Clamby).to receive(:safe?).and_return(true)
      end
      it 'allow non-virus files to pass' do
        expect{ subject }.not_to raise_error(Uploader::InfectedFileError)
      end
    end
  end

  describe '.content_type' do
    context 'with a valid content type' do      
      it 'does not raise an error' do
        expect{ subject }.not_to raise_error(ArgumentError)
      end
    end

    context 'with an invalid content type' do
      let(:filename) { 'filename' }
      it 'allow non-virus files to pass' do
        expect{ subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe '.sanitize_filename' do
    let(:filename) { 'filename;drop table;.doc' }
    it 'sanitizes file names' do
      expect_any_instance_of(
          Aws::S3::Client).to receive(
          :put_object).with(
        body: data,
        bucket: bucket,
        key: 'collection_ref/document_key/filenamedroptable.doc')
      
      subject
    end
  end

  describe '.validate_arguments' do
    
    context 'no filename' do
      let(:filename) { nil }
      it 'requires a filename' do
        expect{ subject }.to raise_error(
          Uploader::UploaderError, "Filename must be provided")
      end
    end

    context 'no data' do
      let(:data) { nil }
      it 'requires data' do
        expect{ subject }.to raise_error(
          Uploader::UploaderError, "File data must be provided")
      end
    end
  end

  describe '.repeat_or_raise' do
    it 'if it receives Uploader::UploaderError, it retries the error a '\
        'configurable number of times before re-raising' do
      allow_any_instance_of(described_class).to receive(:sleep)
      expect_any_instance_of(Aws::S3::Client).
        to receive(:put_object).
        exactly(described_class::UPLOAD_RETRIES+2).and_raise(StandardError)

      expect { subject }.to raise_error(Uploader::UploaderError)
    end
  end

end