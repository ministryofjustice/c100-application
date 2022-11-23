class Uploader
  class DeleteFile < ApiClient
    def initialize(collection_ref:, document_key:, filename:)
      super
      @collection_ref = collection_ref
      @document_key = document_key
      @filename = filename
    end

    def call
      log_delete

      @client.delete_object({
                              bucket: ENV.fetch('AWS_S3_BUCKET', ''),
        key: blob_name
                            })
    rescue StandardError => err
      log_uploader_error(err)
      raise Uploader::UploaderError, err
    end

    private

    def log_delete
      Rails.logger.tagged('delete_file') do
        Rails.logger.info({
                            filename: @filename,
                            collection_ref: @collection_ref,
                            folder: @document_key.to_s
                          })
      end
    end

    def log_uploader_error(err)
      Rails.logger.tagged('delete_file') do
        Rails.logger.warn('Uploader::RequestError':
          {
            error: err.inspect,
            backtrace: err.backtrace
          })
      end
    end
  end
end
