require 'rails_helper'

RSpec.shared_examples 'a document attachable step form' do |options|

  let(:document_key) { options.fetch(:attribute_name) }  # i.e. draft_consent_order
  let(:document_attribute_name) { [document_key, '_document'].join.to_sym }  # i.e. draft_consent_order_document

  describe 'validates file is valid' do
    context 'with valid documents' do
      it 'is valid' do
        expect(subject.save).to be(true)
      end
    end
    context 'with invalid document' do
      let(:document_upload) {
        double(DocumentUpload,
          valid?: false, upload!: true,
          errors: [double('error', type: 'invalid_characters')])
      }
      it 'adds an error if document is not valid' do
        expect(subject.save).to be(false)
        expect(subject.errors.messages).to eq({
          document_attribute_name => ['invalid_characters'] })
      end
    end
  end

end
