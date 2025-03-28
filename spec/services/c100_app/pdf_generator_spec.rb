require 'rails_helper'

RSpec.describe C100App::PdfGenerator do
  context 'when performing end to end test' do
    let(:c100_application) { C100Application.new(
      status: :completed,
      court: Court.new(
        slug: 'slug',
        name: 'name',
        cci_code: '123'),
      created_at: Time.now
    ) }

    let(:presenter) { Summary::C100Form.new(c100_application) }

    before do
      allow(c100_application).to receive(:documents)
      allow(c100_application.documents(:exemption)).to receive(:none?).and_return(true)
      allow(subject).to receive(:pdf_from_presenter).with(presenter).and_return 'test_pdf'
    end

    it 'can render the complete form' do
      allow_any_instance_of(C100Application).to receive(:id).and_return('123-456')
      expect {
        subject.generate(presenter, copies: 0)
      }.not_to raise_error
    end
  end

  context 'when mocking libraries' do

    let(:combiner)   { [] }

    before do
      allow(CombinePDF).to receive(:new).and_return(combiner)
    end


    describe '#generate' do
      let(:c100_application) { double('c100_application') }

      let(:presenter) {
        double(
          'Presenter',
          name: 'Test',
          page_number: '[xx]/[yy]',
          template: 'path/to/template',
          raw_file_path: raw_file_path,
          c100_application: c100_application,
        )
      }
      let(:document)  { 'a form document' }
      let(:raw_file_path) { nil }
      let(:footer) { '<footer>' }

      before do
        allow(c100_application).to receive(:reference_code).and_return('12345/XYZ')
        allow_any_instance_of(C100App::PdfGenerator).to receive(:footer_line).and_return(footer)
      end

      it 'generates a PDF document via Grover' do
        allow_any_instance_of(C100App::PdfGenerator).to receive(:render).and_return('html to render')
        expect(Grover).to receive(:new).with('html to render', footer_template: footer).and_return(double(to_pdf: document))
        subject.generate(presenter, copies: 0)
      end

      it 'renders a form using a presenter' do
        expect(ApplicationController).to receive(:render).with(
          template: 'path/to/template',
          format: :pdf,
          locals: { presenter: presenter }
        ).and_return(document)

        allow(Grover).to receive(:new).and_return(double(to_pdf: document))
        # Using 0 copies just to make this test scenario simpler to mock,
        # as we want to test here only the call to `pdf_from_presenter`
        subject.generate(presenter, copies: 0)
      end

      it 'generates a PDF document with N copies' do
        expect(subject).to receive(:pdf_from_presenter).with(presenter).and_return(document)
        expect(CombinePDF).to receive(:parse).twice.with(document).and_return(document)

        subject.generate(presenter, copies: 2)

        expect(combiner).to match_array([document, document])
      end

      context 'appends a raw document if there is one specified in the presenter' do
        let(:raw_file_path) { 'test/path.pdf' }

        it 'generates the PDF' do
          expect(subject).to receive(:pdf_from_presenter).with(presenter).and_return(document)
          expect(CombinePDF).to receive(:parse).with(document).and_return(document)
          expect(CombinePDF).to receive(:load).with('test/path.pdf').and_return(document)

          subject.generate(presenter, copies: 1)

          expect(combiner).to match_array([document, document])
        end
      end
    end

    describe '#to_pdf' do
      let(:combiner) { double('Combiner', objects: combiner_object) }

      context 'there is data in the combiner' do
        let(:combiner_object) { [{Producer: 'Ruby CombinePDF'}, {pdf_page: 'pdf data'}] }

        it 'delegates to the combiner' do
          expect(combiner).to receive(:to_pdf)
          subject.to_pdf
        end
      end

      context 'there is no data yet in the combiner' do
        let(:combiner_object) { [] }

        it 'returns an empty string without calling the combiner' do
          expect(combiner).not_to receive(:to_pdf)
          expect(subject.to_pdf).to eq('')
        end
      end
    end

    describe '#pdf_data_rendered?' do
      let(:combiner) { double('Combiner', objects: combiner_object) }

      context 'there is data in the combiner' do
        let(:combiner_object) { [{Producer: 'Ruby CombinePDF'}, {pdf_page: 'pdf data'}] }
        it { expect(subject.pdf_data_rendered?).to eq(true) }
      end

      context 'there is no data yet in the combiner' do
        let(:combiner_object) { [{Producer: 'Ruby CombinePDF'}] }
        it { expect(subject.pdf_data_rendered?).to eq(false) }
      end

      context 'there is no combiner haeader' do
        let(:combiner_object) { [{Producer: 'something else'}, {pdf_page: 'pdf data'}] }
        it { expect(subject.pdf_data_rendered?).to eq(false) }
      end
    end
  end
end
