require 'spec_helper'

RSpec.describe Steps::Application::HasCourtOrderUploadsForm do

  let(:c100_application) { instance_double(C100Application,
    documents: documents,
    files_collection_ref: '123',
    update: true) }
  let(:arguments) { {
    c100_application: c100_application,
    has_court_order_uploads: has_court_order_uploads
  } }
  let(:has_court_order_uploads) { 'no' }
  let(:documents) { [] }

  subject { described_class.new(arguments) }

  before do
    allow(Uploader).to receive(:delete_file)
  end

  describe 'validations on field presence' do
    it { should validate_presence_of(:has_court_order_uploads, :inclusion) }
  end

  context 'when there is a c100_application associated with the form' do

    context 'when answer is `yes`' do
      let(:has_court_order_uploads) { 'yes' }

      it 'saves the record' do
        expect(c100_application).to receive(:update).with(
          has_court_order_uploads: GenericYesNo::YES
        ).and_return(true)
        expect(subject.save).to be(true)
      end
    end

    context 'when answer is `no`' do
      let(:has_court_order_uploads) { 'no' }

      it 'saves the record' do
        expect(c100_application).to receive(:update).with(
          has_court_order_uploads: GenericYesNo::NO
        ).and_return(true)
        expect(subject.save).to be(true)
      end
    end
  end

  describe '#save' do
    context 'when no c100_application is associated with the form' do
      let(:c100_application) { nil }

      it 'raises an error' do
        expect { subject.save }.to raise_error(BaseForm::C100ApplicationNotFound)
      end
    end
    
    context 'when answer is no' do
      let(:documents) { [double(name: 'file.jpg')] }
      it 'deletes files' do
        subject.save
        expect(Uploader).to have_received(:delete_file)
      end
    end

  end

end
