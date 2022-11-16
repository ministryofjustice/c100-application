require 'rails_helper'

RSpec.shared_examples 'a document attachable step form' do |options|

  let(:document_key) { options.fetch(:attribute_name) }  # i.e. draft_consent_order
  let(:document_attribute_name) { [document_key, '_document'].join.to_sym }  # i.e. draft_consent_order_document

  # subject is described_class.new(arguments) for the form

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

  # describe '.document_attribute' do
  #   it 'provides the full document attribunte value' do
  #   end
  # end

  # describe '.document' do
  # end
  #   it 'gets the document from the form' do
  #   end

  # describe '.document_provided?' do
  #   it 'gets already uploaded documents of the defined type if they are present' do
  #   end
  #   it 'gets any newly uploaded documents if they are present' do
  #   end
  # end

  # describe '.upload_document_if_present' do
  #   it 'calls the uploader' do
  #   end
  #   it 'raises errors if any errors found on the documents' do
  #   end
  #   it 'returns false if errors found' do
  #   end
  # end
end

# RSpec.shared_examples 'a mandatory document attachable step form' do |options|


#   include_examples 'a document attachable step form'
 
#   # describe '.check_document_presence' do
#   #   it 'requires a document to be present' do
#   #   end
#   # end

# end












































#   let(:document_key) { options.fetch(:document_key) }  # i.e. draft_consent_order
#   let(:document_attribute_name) { [document_key, '_document'].join.to_sym }  # i.e. draft_consent_order_document
#   let(:documents) { [] }

#   before do
#     allow(Uploader).to receive(:list_files).and_return(double(content: []))
#   end

#   context 'when no c100_application is associated with the form' do
#     let(:c100_application) { nil }

#     it 'raises an error' do
#       expect { subject.save }.to raise_error(C100ApplicationNotFound)
#     end
#   end

#   context 'when form is valid' do

#     before do
#       allow(c100_application).to receive(:documents).
#         with(document_key). # i.e. draft_consent_order
#         and_return(documents)
#     end

#     context 'when providing an attached document' do
#       let(:document_attribute_value) { fixture_file_upload('image.jpg', 'image/jpeg') }

#       context 'document upload successful' do
#         it 'saves the record' do
#           expect(c100_application).to receive(:update).with(
#               document_key => nil
#           ).and_return(true)

#           expect(Uploader).to receive(:add_file).
#             with(hash_including(document_key: document_key)).
#             and_return(double(name: '123/foo/bar.png'))

#           expect(subject.save).to be(true)
#         end
#       end

#       context 'document upload unsuccessful' do
#         it 'doesn\'t save the record' do
#           expect(c100_application).not_to receive(:update)
#           expect(subject).to receive(:upload_document_if_present).and_return(false)
#           expect(subject.save).to be(false)
#         end
#       end
#     end
#   end

#   context 'validations for document requirement' do
#     before do
#       allow(c100_application).to receive(:documents).with(document_key).and_return(documents)
#     end

#     context 'document is not present' do

#       it 'returns false' do
#         expect(subject.save).to be(false)
#       end

#       it 'has a validation error on the text field' do
#         expect(subject).to_not be_valid
#         expect(subject.errors[document_key]).to eq(['You must choose a file to upload'])
#       end
#     end

#     context 'when document is not valid' do
#       let(:document_attribute_value) { fixture_file_upload('image.jpg', 'application/zip') }

#       it 'should retrieve the errors from the uploader' do
#         expect(subject.errors).to receive(:add).with(document_attribute_name, :content_type).and_call_original
#         expect(subject).to_not be_valid
#       end
#     end
#   end

# end
