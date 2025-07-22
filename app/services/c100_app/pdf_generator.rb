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
      html_size = html&.bytesize || 0
      Rails.logger.info "[PDF] HTML rendered (#{html_size} bytes) in #{Time.current - start_time}s"
      
      if html.blank?
        Rails.logger.error "[PDF] HTML rendering returned nil/empty content"
        raise "HTML rendering failed - no content generated"
      end
      
      # Allow timeout override via environment variable
      timeout_minutes = ENV.fetch('PDF_TIMEOUT_MINUTES', '15').to_i
      timeout_ms = timeout_minutes * 60 * 1000
      
      # Build options gradually to identify problematic ones
      grover_options = {
        format: 'A4',
        timeout: timeout_ms
      }
      
      # Add footer template (this might be the culprit)
      unless ENV['PDF_SKIP_FOOTER'] == 'true'
        begin
          footer_content = footer_line(presenter)
          if footer_content&.length && footer_content.length < 1000  # Reasonable size check
            grover_options[:footer_template] = footer_content
          else
            Rails.logger.warn "[PDF] Skipping footer - too large or invalid: #{footer_content&.length} chars"
          end
        rescue => footer_error
          Rails.logger.error "[PDF] Footer generation failed: #{footer_error.message}"
        end
      end
      
      # Log Chrome options for debugging
      Rails.logger.info "[PDF] Grover options: #{grover_options.inspect}"
      
      grover_start = Time.current
      Rails.logger.info "[PDF] Creating Grover instance with HTML length: #{html.length}"
      
      # Test with minimal HTML if environment variable is set
      if ENV['PDF_TEST_MINIMAL'] == 'true'
        Rails.logger.info "[PDF] Using minimal HTML for testing"
        html = "<html><body><h1>Test PDF</h1><p>This is a test PDF generation.</p></body></html>"
      end
      
      begin
        # Try configured options first, fall back to minimal if they fail
        Rails.logger.info "[PDF] Attempting PDF generation with configured options"
        grover = Grover.new(html, **grover_options)
        pdf_data = grover.to_pdf
        
        # If configured options return nil, fall back to minimal
        if pdf_data.nil? || pdf_data.empty?
          Rails.logger.warn "[PDF] Configured options failed, falling back to minimal options"
          minimal_grover = Grover.new(html, format: 'A4')
          pdf_data = minimal_grover.to_pdf
          Rails.logger.info "[PDF] Fallback successful, PDF size: #{pdf_data&.bytesize || 0} bytes"
        else
          Rails.logger.info "[PDF] Configured options successful, PDF size: #{pdf_data.bytesize} bytes"
        end
        
      rescue => grover_error
        Rails.logger.error "[PDF] Grover error: #{grover_error.class} - #{grover_error.message}"
        Rails.logger.error "[PDF] Grover backtrace: #{grover_error.backtrace.first(3).join('\n')}"
        raise grover_error
      end
      
      grover_time = Time.current - grover_start
      
      pdf_size = pdf_data&.bytesize || 0
      Rails.logger.info "[PDF] Grover PDF generation completed in #{grover_time}s (#{pdf_size} bytes)"
      Rails.logger.info "[PDF] Total PDF generation time: #{Time.current - start_time}s"
      
      if pdf_data.blank?
        Rails.logger.error "[PDF] Grover returned nil/empty PDF data"
        raise "PDF generation failed - no PDF data returned from Grover"
      end
      
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
