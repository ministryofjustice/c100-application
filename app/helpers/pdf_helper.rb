module PdfHelper
  MIME_TYPES = {
    '.png' => 'image/png',
    '.jpg' => 'image/jpeg',
    '.jpeg' => 'image/jpeg',
    '.gif' => 'image/gif',
    '.svg' => 'image/svg+xml',
    '.webp' => 'image/webp',
    '.css' => 'text/css',
  }.freeze

  ASSET_PATHS = %w[
    app/assets/images
    app/assets/builds
  ].freeze

  def pdf_asset_base64(path)
    asset_path = find_asset(path)
    raise "Could not find asset '#{path}'" if asset_path.nil?

    content = File.binread(asset_path)
    content_type = MIME_TYPES[File.extname(asset_path).downcase] || 'application/octet-stream'

    base64 = Base64.encode64(content).gsub(/\s+/, '')
    "data:#{content_type};base64,#{Rack::Utils.escape(base64)}"
  end

  def find_asset(path)
    ASSET_PATHS.each do |asset_dir|
      asset_path = Rails.root.join(asset_dir, path)
      return asset_path if File.exist?(asset_path)

      asset_path_with_css = Rails.root.join(asset_dir, "#{path}.css")
      return asset_path_with_css if File.exist?(asset_path_with_css)
    end

    nil
  end
end
