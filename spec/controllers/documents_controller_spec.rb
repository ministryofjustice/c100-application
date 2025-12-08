require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  let(:collection_ref) { '12345' }
  let(:document_key) { 'some_step' }
  let(:filename) { 'dGVzdCBmaWxlLnR4dA==\n' } # 'test file.txt' - base64 encoded
  let(:another_filename) { 'YW5vdGhlcg==\n' } # 'another' - base64 encoded
  let(:current_c100_application) {
    instance_double(
      C100Application,
      files_collection_ref: collection_ref,
      completed?: false,
      status: :screening
    )
  }
  let(:file) { fixture_file_upload('image.jpg', 'image/jpeg') }

  let(:document_upload) { instance_double(
    DocumentUpload,
    upload!: {},
    valid?: true,
    errors?: false,
    to_hash: {
      name: 'image.jpg',
      encoded_name: "aW1hZ2UuanBn\n", collection_ref: '12345'
    }) }

  before do
    allow(subject).to receive(:current_c100_application).and_return(current_c100_application)
    session[:current_step_path] = 'https://step/to/redirect'
  end

  context 'with DocumentUpload mock' do

    before do
      allow(DocumentUpload).to receive(:new).and_return(document_upload)
    end

    include_examples 'checks the validity of the current c100 application on destroy', { document_key: :foo_bar }

    describe '#destroy' do
      context 'response formats' do
        let(:params) { {
          document_key: 'miam_certificate',
          id: another_filename
        } }

        before do
          expect(Uploader).to receive(:delete_file).with(collection_ref: collection_ref, document_key: 'miam_certificate', filename: 'another').and_return({})
        end

        context 'HTML format' do
          it 'should delete the file and redirect to the step' do
            delete :destroy, params: params
            expect(subject).to redirect_to('https://step/to/redirect')
          end
        end

        context 'JSON format' do
          it 'should respond with an empty body and success status code' do
            delete :destroy, params: params, format: :json
            expect(response.status).to eq(204)
            expect(response.body).to eq('')
          end
        end
      end
    end
  end
end