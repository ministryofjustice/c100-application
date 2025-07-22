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
      start_time = Time.current
      Rails.logger.info "[PDF] Starting PDF generation for #{presenter.name}"
      
      html = render(presenter)
      html_size = html.bytesize
      Rails.logger.info "[PDF] HTML rendered (#{html_size} bytes) in #{Time.current - start_time}s"
      
      # Allow timeout override via environment variable
      timeout_minutes = ENV.fetch('PDF_TIMEOUT_MINUTES', '15').to_i
      timeout_ms = timeout_minutes * 60 * 1000
      
      grover_options = {
        footer_template: footer_line(presenter),
        timeout: timeout_ms,
        debug: Rails.env.development?
      }
      
      # Log Chrome options for debugging
      Rails.logger.info "[PDF] Grover options: #{grover_options.inspect}"
      
      grover_start = Time.current
      grover = Grover.new(html, **grover_options)
      pdf_data = grover.to_pdf
      grover_time = Time.current - grover_start
      
      Rails.logger.info "[PDF] Grover PDF generation completed in #{grover_time}s (#{pdf_data.bytesize} bytes)"
      Rails.logger.info "[PDF] Total PDF generation time: #{Time.current - start_time}s"
      
      pdf_data
    rescue => e
      Rails.logger.error "[PDF] PDF generation failed after #{Time.current - start_time}s: #{e.class} - #{e.message}"
      Rails.logger.error "[PDF] Backtrace: #{e.backtrace.first(5).join('\n')}"
      raise
    end

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
  end
end
