require 'rails_helper'

RSpec.describe PdfGenerationJob, type: :job do
  let!(:c100_application) { C100Application.create }
  let(:pdf_presenter) {
    instance_double(Summary::PdfPresenter, generate: nil, to_pdf: 'pdf content')
  }

  before do
    allow(Summary::PdfPresenter).to receive(:new).with(c100_application).and_return(pdf_presenter)
  end

  after do
    Rails.cache.delete("C100_Application_#{c100_application.id}_completed")
    Rails.cache.delete("C100_Application_#{c100_application.id}_draft")
  end

  describe '#perform' do
    it 'generates and caches the PDF for a completed type' do
      described_class.perform_now(application_id: c100_application.id, type: 'completed')

      key = "C100_Application_#{c100_application.id}_completed"
      expect(Rails.cache.read(key)).to eq('pdf content')
    end

    it 'generates and caches the PDF for a draft type' do
      described_class.perform_now(application_id: c100_application.id, type: 'draft')

      key = "C100_Application_#{c100_application.id}_draft"
      expect(Rails.cache.read(key)).to eq('pdf content')
    end

    it 'calls generate and to_pdf on the presenter' do
      expect(pdf_presenter).to receive(:generate)
      expect(pdf_presenter).to receive(:to_pdf).and_return('pdf content')

      described_class.perform_now(application_id: c100_application.id, type: 'completed')
    end

    it 'writes the correct key format to the cache' do
      described_class.perform_now(application_id: c100_application.id, type: 'completed')

      cached_keys = Rails.cache.instance_variable_get(:@data)&.keys || []
      expected_key = "C100_Application_#{c100_application.id}_completed"
      expect(cached_keys).to include(expected_key)
    end
  end
end
