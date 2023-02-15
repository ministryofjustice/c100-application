require 'spec_helper'

RSpec.describe Steps::Opening::ConsentOrderUploadForm do
  
  let(:arguments) { {
    c100_application: c100_application,
    draft_consent_order_document: document_upload
  } }

  let(:document_upload) {
    double(DocumentUpload,
      valid?: true, upload!: true, errors: [])
  }
  let(:document) { instance_double(Document, name: 'miam_certificate.pdf')}
  let(:documents) { [document] }

  let(:c100_application) { instance_double(C100Application,
    files_collection_ref: '123',
    documents: documents, document: document) }

  subject { described_class.new(arguments) }

  describe '#document_key' do
    it 'is correct' do
      expect(subject.document_key).to eq(:draft_consent_order)
    end
  end

  before do
    allow(DocumentUpload).to receive(:new).and_return(document_upload)
    allow(c100_application).to receive(:document).and_return(nil)
  end

  it_behaves_like 'a document attachable step form', attribute_name: :draft_consent_order

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
        expect(subject.errors[:draft_consent_order_document]).not_to be_empty
      end
    end

    context 'when a conflicting file is already uploaded' do

      let(:document_key) { :miam_certificate }

      before do
        allow(c100_application).to receive(:document).with(:miam_certificate).and_return(document)
      end

      it 'deletes any other documents if the document_key is :draft_consent_order and there is a miam_certificate' do
        expect(Uploader).to receive(:delete_file).with(collection_ref: c100_application.files_collection_ref,
                                                       document_key: document_key,
                                                       filename: 'miam_certificate.pdf')
        subject.save
      end
    end

    context 'when form is valid' do

      it 'saves the record' do
        expect(subject.save).to be(true)
      end
    end
  end
end
