require 'rails_helper'

RSpec.describe PdfHelper, type: :helper do
  describe '#find_asset' do
    context 'when asset exists in images directory' do
      it 'returns the asset path' do
        asset_path = Rails.root.join('app', 'assets', 'images', 'govuk-crest.svg')
        expect(helper.find_asset('govuk-crest.svg')).to eq(asset_path)
      end
    end

    context 'when asset exists in builds directory' do
      it 'returns the asset path' do
        asset_path = Rails.root.join('app', 'assets', 'builds', 'pdf_summary.css')
        expect(helper.find_asset('pdf_summary.css')).to eq(asset_path)
      end
    end

    context 'when asset exists with .css extension appended' do
      it 'returns the asset path with .css extension' do
        asset_path = Rails.root.join('app', 'assets', 'builds', 'pdf_summary.css')
        expect(helper.find_asset('pdf_summary')).to eq(asset_path)
      end
    end

    context 'when asset does not exist' do
      it 'returns nil' do
        expect(helper.find_asset('nonexistent_file.png')).to be_nil
      end
    end
  end

  describe '#pdf_asset_base64' do
    context 'when asset exists' do
      it 'returns a base64 encoded data URI' do
        result = helper.pdf_asset_base64('pdf_summary.css')

        expect(result).to start_with('data:text/css;base64,')
      end

      it 'returns correct MIME type for PNG files' do
        allow(helper).to receive(:find_asset).with('test.png').and_return(
          Rails.root.join('app', 'assets', 'images', 'test.png')
        )
        allow(File).to receive(:binread).and_return('fake image content')

        result = helper.pdf_asset_base64('test.png')

        expect(result).to start_with('data:image/png;base64,')
      end

      it 'returns correct MIME type for SVG files' do
        result = helper.pdf_asset_base64('govuk-crest.svg')

        expect(result).to start_with('data:image/svg+xml;base64,')
      end

      it 'falls back to application/octet-stream for unknown extensions' do
        allow(helper).to receive(:find_asset).with('test.unknown').and_return(
          Rails.root.join('app', 'assets', 'images', 'test.unknown')
        )
        allow(File).to receive(:binread).and_return('fake content')

        result = helper.pdf_asset_base64('test.unknown')

        expect(result).to start_with('data:application/octet-stream;base64,')
      end
    end

    context 'when asset does not exist' do
      it 'raises an error' do
        expect {
          helper.pdf_asset_base64('nonexistent_file.png')
        }.to raise_error(RuntimeError, "Could not find asset 'nonexistent_file.png'")
      end
    end
  end
end
