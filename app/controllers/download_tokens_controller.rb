class DownloadTokensController < ApplicationController
  respond_to :html

  def show
    download_token = DownloadToken.find_by_token params[:token]

    redirect_to file_not_found_errors_path, allow_other_host: true and return unless download_token
    redirect_to download_token.url, allow_other_host: true
  end
end
