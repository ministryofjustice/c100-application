module C100App
  # rubocop:disable Metrics/ClassLength
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

    # rubocop:disable Metrics/AbcSize
    def pdf_from_presenter(presenter)
      start_time = Time.current
      Rails.logger.info "[PDF] Starting PDF generation for #{presenter.name}"

      html = prepare_html(presenter, start_time)
      grover_options = build_grover_options(presenter)

      pdf_data = generate_pdf_with_fallback(html, grover_options, start_time)
      Rails.logger.info "[PDF] Total PDF generation time: #{Time.current - start_time}s"

      validate_pdf_data(pdf_data)
      pdf_data
    rescue StandardError => e
      Rails.logger.error "[PDF] PDF generation failed after #{Time.current - start_time}s: #{e.class} - #{e.message}"
      Rails.logger.error "[PDF] Backtrace: #{e.backtrace.first(5).join('\n')}"
      raise
    end
    # rubocop:enable Metrics/AbcSize

    def render(presenter)
      html = ApplicationController.render(
        template: presenter.template.gsub(/\.pdf$/, ''),
        format: :pdf,
        locals: { presenter: }
      )

      # Save HTML for debugging in development
      if Rails.env.development?
        debug_html_path = Rails.root.join('tmp', 'pdf_debug_output.html')
        File.write(debug_html_path, html)
        Rails.logger.info "[PDF] Debug HTML saved to: #{debug_html_path}"
      end

      html
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

    def prepare_html(presenter, start_time)
      html = render(presenter)
      html_size = html&.bytesize || 0
      Rails.logger.info "[PDF] HTML rendered (#{html_size} bytes) in #{Time.current - start_time}s"

      if html.blank?
        Rails.logger.error "[PDF] HTML rendering returned nil/empty content"
        raise "HTML rendering failed - no content generated"
      end

      # Test with minimal HTML if environment variable is set
      if ENV['PDF_TEST_MINIMAL'] == 'true'
        Rails.logger.info "[PDF] Using minimal HTML for testing"
        html = "<html><body><h1>Test PDF</h1><p>This is a test PDF generation.</p></body></html>"
      end

      html
    end

    def build_grover_options(presenter)
      timeout_minutes = ENV.fetch('PDF_TIMEOUT_MINUTES', '15').to_i
      timeout_ms = timeout_minutes * 60 * 1000

      grover_options = {
        format: 'A4',
        timeout: timeout_ms
      }

      add_footer_template(grover_options, presenter)
      Rails.logger.info "[PDF] Grover options: #{grover_options.inspect}"

      grover_options
    end

    def add_footer_template(grover_options, presenter)
      return if ENV['PDF_SKIP_FOOTER'] == 'true'

      begin
        footer_content = footer_line(presenter)
        if footer_content&.length && footer_content.length < 1000
          grover_options[:footer_template] = footer_content
        else
          Rails.logger.warn "[PDF] Skipping footer - too large or invalid: #{footer_content&.length} chars"
        end
      rescue StandardError => footer_error
        Rails.logger.error "[PDF] Footer generation failed: #{footer_error.message}"
      end
    end

    # rubocop:disable Metrics/AbcSize
    def generate_pdf_with_fallback(html, grover_options, _start_time)
      Rails.logger.info "[PDF] Creating Grover instance with HTML length: #{html.length}"

      begin
        Rails.logger.info "[PDF] Attempting PDF generation with configured options"
        grover = Grover.new(html, **grover_options)
        pdf_data = grover.to_pdf

        if pdf_data.nil? || pdf_data.empty?
          Rails.logger.warn "[PDF] Configured options failed, falling back to minimal options"
          minimal_grover = Grover.new(html, format: 'A4')
          pdf_data = minimal_grover.to_pdf
          Rails.logger.info "[PDF] Fallback successful, PDF size: #{pdf_data&.bytesize || 0} bytes"
        else
          Rails.logger.info "[PDF] Configured options successful, PDF size: #{pdf_data.bytesize} bytes"
        end
      rescue StandardError => grover_error
        Rails.logger.error "[PDF] Grover error: #{grover_error.class} - #{grover_error.message}"
        Rails.logger.error "[PDF] Grover backtrace: #{grover_error.backtrace.first(3).join('\n')}"
        raise grover_error
      end

      pdf_data
    end
    # rubocop:enable Metrics/AbcSize

    def validate_pdf_data(pdf_data)
      return unless pdf_data.blank?

      Rails.logger.error "[PDF] Grover returned nil/empty PDF data"
      raise "PDF generation failed - no PDF data returned from Grover"
    end
  end
  # rubocop:enable Metrics/ClassLength
end
