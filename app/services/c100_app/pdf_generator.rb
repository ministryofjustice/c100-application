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
        timeout: (15 * 60 * 1000), # 15 minutes max timeout
        format: 'A4',
        print_background: true,
        prefer_css_page_size: true,
        wait_until: 'domcontentloaded', # Faster than 'networkidle0'
        cache: false, # Disable cache for consistent results
        launch_args: optimized_launch_args
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

    # rubocop:disable Metrics/MethodLength
    def optimized_launch_args
      [
        '--no-sandbox',
        '--disable-setuid-sandbox',
        '--disable-gpu',
        '--disable-dev-shm-usage',
        '--disable-background-networking',
        '--disable-background-timer-throttling',
        '--disable-backgrounding-occluded-windows',
        '--disable-breakpad',
        '--disable-component-update',
        '--disable-default-apps',
        '--disable-domain-reliability',
        '--disable-extensions',
        '--disable-features=AudioServiceOutOfProcess,IsolateOrigins',
        '--disable-hang-monitor',
        '--disable-ipc-flooding-protection',
        '--disable-notifications',
        '--disable-popup-blocking',
        '--disable-print-preview',
        '--disable-prompt-on-repost',
        '--disable-renderer-backgrounding',
        '--disable-site-isolation-trials',
        '--font-render-hinting=medium'
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
