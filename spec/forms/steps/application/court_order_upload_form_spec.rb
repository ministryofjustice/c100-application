require 'spec_helper'

RSpec.describe Steps::Application::CourtOrderUploadsForm do
  
  let(:arguments) { {
    c100_application: c100_application,
    court_order_uploads_document: document_upload
  } }

  let(:document_upload) {
    double(DocumentUpload,
      valid?: true, upload!: true, errors: [])
  }
  let(:document) { double('document', upload!: true)}
  let(:documents) { [document] }

  let(:c100_application) { instance_double(C100Application,
    files_collection_ref: '123',
    documents: documents) }

  subject { described_class.new(arguments) }

  describe '#document_key' do
    it 'is correct' do
      expect(subject.document_key).to eq(:court_order_uploads)
    end
  end

  before do
    allow(DocumentUpload).to receive(:new).and_return(document_upload)
  end

  it_behaves_like 'a document attachable step form', attribute_name: :court_order_uploads

  describe '#save' do

    context 'when no c100_application is associated with the form' do
      let(:c100_application) { nil }

      it 'raises an error' do
        expect { subject.save }.to raise_error(BaseForm::C100ApplicationNotFound)
      end
    end

    context 'when no documents uploaded' do
      let(:documents) { [] }
      let(:document_upload) { nil }

      it 'has validation error on the base' do
        expect(subject).to_not be_valid
        expect(subject.errors[:court_order_uploads_document]).not_to be_empty
      end
    end

    context 'when form is valid' do

      it 'saves the record' do
        expect(subject.save).to be(true)
      end
    end
  end
end
