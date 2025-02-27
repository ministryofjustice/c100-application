class DocumentsController < ApplicationController
  before_action :check_c100_application_presence, :check_c100_application_status

  respond_to :html, :json, :js

  def destroy
    Uploader.delete_file(
      collection_ref:,
      document_key: document_key_param,
      filename: decoded_filename
    )

    respond_to do |format|
      format.html { redirect_to current_step_path, allow_other_host: true }
      format.json { head :no_content }
      format.js   { head :no_content }
    end
  end

  private

  def collection_ref
    current_c100_application.files_collection_ref
  end

  def decoded_filename
    Base64.decode64(filename_param)
  end

  def filename_param
    document_params[:id]
  end

  def document_param
    document_params[:document]
  end

  def document_key_param
    params[:document_key]
  end

  def document_params
    params.permit(:_method, :id, :document, :document_key, :authenticity_token)
  end
end
