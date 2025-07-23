module C100App
  class PdfGenerator
    def generate(presenter, copies:)
      main_doc = pdf_from_presenter(presenter)
      raw_file = presenter.raw_file_path

      copies.times do
        combiner << CombinePDF.parse(main_doc)
        combiner << CombinePDF.load(raw_file) if raw_file
      end
    end

    def pdf_data_rendered?
      combiner.objects.size >= 2 &&
        combiner.objects[0][:Producer].include?('Ruby CombinePDF')
    end

    def to_pdf
      return '' unless pdf_data_rendered?
      combiner.to_pdf
    end

    private

    def pdf_from_presenter(presenter)
      html = render(presenter)
      grover_options = {
        footer_template: footer_line(presenter),
        timeout: (15 * 60 * 1000) # 15 minutes max timeout
      }

      Grover.new(html, **grover_options).to_pdf
    end

    def render(presenter)
      ApplicationController.render(
        template: presenter.template.gsub(/\.pdf$/, ''),
        format: :pdf,
        locals: { presenter: }
      )
    end

    def footer_line(presenter)
      reference_code = presenter.c100_application.reference_code
      name = presenter.name
      "<h1 style='font-size:18px;font-weight:normal;text-align:right;width: 100%'>
      <span style='padding:15px'>#{reference_code}</span>
      <span style='padding:15px'>#{name}</span>
      <span class='pageNumber'></span>/<span class='totalPages' style='padding-right: 57px'></span>
      </h1>"
    end

    def producer
      @_producer ||= Grover.new
    end

    def combiner
      @_combiner ||= CombinePDF.new
    end
  end
end
