module PdfHelper
  def pdf_asset_base64(path)
    # This is from originaly from wicked pdf gem (2.6.3 version)
    asset = find_asset(path)
    raise "Could not find asset '#{path}'" if asset.nil?

    base64 = Base64.encode64(asset.to_s).gsub(/\s+/, '')
    "data:#{asset.content_type};base64,#{Rack::Utils.escape(base64)}"
  end

  def find_asset(path)
    # This is from originaly from wicked pdf gem (2.6.3 version)
    if Rails.application.assets.respond_to?(:find_asset)
      Rails.application.assets.find_asset(path, base_path: Rails.application.root.to_s)
    else
      Sprockets::Railtie.build_environment(Rails.application).find_asset(path, base_path: Rails.application.root.to_s)
    end
  end
end
