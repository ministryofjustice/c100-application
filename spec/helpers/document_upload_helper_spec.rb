require 'rails_helper'

RSpec.describe DocumentUploadHelper do
  let(:c100_application) { double(C100Application, files_collection_ref: 'r3f3r3nc3') }
  let(:form) { double('Form object') }

  before do
    allow(helper).to receive(:current_c100_application).and_return(c100_application)
    allow(c100_application).to receive(:documents).with(:some_step).and_return(documents)
  end

  describe '#document_upload_field' do
    subject { helper.document_upload_field(form, :some_step, label_text: 'A file',
                                           paragraph_text: 'Some text') }

    context 'when there is no document uploaded' do
      let(:documents) { [] }

      it 'renders the upload field' do
        expect(helper).to receive(:render).with(
          partial: 'steps/shared/document_upload/document_upload_field',
          locals: {
            form:       form,
            field_name: :some_step_document,
            label_text: 'A file',
            paragraph_text: 'Some text'
          }
        )
        subject
      end
    end

    context 'when there is an uploaded document' do
      let(:documents) { [double(Document, name: 'shopping_list.pdf')] }

      it { is_expected.to be_nil }
    end
  end

  describe '#multi_document_upload_field' do
    subject { helper.multi_document_upload_field(form, :some_step, label_text: 'A file',
                                           paragraph_text: 'Some text') }

    context 'when there is an uploaded document' do
      let(:documents) { [double(Document, name: 'shopping_list.pdf')] }

      it 'renders the upload field' do
        expect(helper).to receive(:render).with(
          partial: 'steps/shared/document_upload/document_upload_field',
          locals: {
            form:       form,
            field_name: :some_step_document,
            label_text: 'A file',
            paragraph_text: 'Some text'
          }
        )
        subject
      end
    end
  end

  describe '#display_current_document' do
    subject { helper.display_current_document(:some_step) }

    context 'when there is no document uploaded' do
      let(:documents) { [] }

      it { is_expected.to be_nil }
    end

    context 'when there is an uploaded document' do
      let(:documents) { [instance_double(Document, name: 'shopping_list.pdf')] }

      it 'renders the uploaded document partial' do
        expect(helper).to receive(:render).with(
          partial: 'steps/shared/document_upload/current_document',
          locals: {
            current_document: documents.first,
            document_key: :some_step
          }
        )
        subject
      end
    end
  end

  describe '#display_current_documents' do
    subject { helper.display_current_documents(:some_step) }

    context 'when there is no document uploaded' do
      let(:documents) { [] }

      it { is_expected.to be_nil }
    end

    context 'when there is an uploaded document' do
      let(:documents) { [instance_double(Document, name: 'shopping_list.pdf'), instance_double(Document, name: 'shopping_list2.pdf')] }

      it 'renders the uploaded document partial' do
        expect(helper).to receive(:render).with(
          partial: 'steps/shared/document_upload/current_documents',
          locals: {
            current_documents: documents,
            document_key: :some_step
          }
        )
        subject
      end
    end
  end
end
