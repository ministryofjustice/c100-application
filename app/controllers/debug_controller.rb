class DebugController < ApplicationController
  # Only allow in development environment
  before_action :ensure_development

  def pdf_html
    # Serve the most recent debug HTML file
    debug_html_path = Rails.root.join('tmp', 'pdf_debug_output.html')

    if File.exist?(debug_html_path)
      html_content = File.read(debug_html_path)
      render html: html_content.html_safe
    else
      render html: '<h1>No PDF debug HTML found</h1><p>Generate a PDF first to see the HTML content.</p>'.html_safe
    end
  end

  def pdf_preview
    application = C100Application.find(params[:id])

    # Generate the HTML that would be sent to Grover
    presenter = Summary::C100Form.new(application)

    html = ApplicationController.render(
      template: presenter.template.gsub(/\.pdf$/, ''),
      format: :pdf,
      locals: { presenter: presenter }
    )

    # Save for debugging using secure filename with timestamp
    timestamp = Time.current.strftime('%Y%m%d_%H%M%S')
    debug_html_filename = "pdf_debug_#{timestamp}.html"
    debug_html_path = Rails.root.join('tmp', debug_html_filename)
    File.write(debug_html_path, html)

    render html: html.html_safe
  rescue ActiveRecord::RecordNotFound
    render html: '<h1>Application not found</h1>'.html_safe
  rescue StandardError => e
    render html: "<h1>Error generating PDF preview</h1><p>#{e.message}</p>".html_safe
  end

  private

  def ensure_development
    return if Rails.env.development?
    head :not_found
  end
end
