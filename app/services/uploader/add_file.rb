class Uploader
  class AddFile < ApiClient
    UPLOAD_RETRIES = 2

    def initialize(collection_ref:, document_key:, filename:, data:)
      super
      @collection_ref = collection_ref
      @document_key = document_key
      @filename = filename
      @data = data
      @retries = 0
    end

    def call
      validate_arguments
      sanitize_filename
      scan_file
      upload
    end

    private

    def scan_file
      return if ENV.fetch('SKIP_VIRUS_CHECK', '').present?

      file_to_test = Tempfile.new
      file_to_test << @data.force_encoding("UTF-8")
      file_to_test.rewind
      return if Clamby.safe?(file_to_test.path)

      log_infected_file
      raise Uploader::InfectedFileError
    end

    def upload
      @client.put_object({
        body: @data,
        bucket: ENV.fetch('AWS_BUCKET', ''),
        key: blob_name
      })
    rescue KeyError => err # e.g. Env not found
      raise KeyError, err
    rescue StandardError => err
      repeat_or_raise(err)
    end

    def content_type_valid?
      type = MimeMagic.by_path(@filename).try(:type)
      raise ArgumentError, 'File content type not recognised' unless type
      true
    end

    def sanitize_filename
      @filename = @filename.unicode_normalize(:nfkd)
      @filename = Sanitize.fragment(@filename)
        .gsub(/[^0-9a-zA-Z.\-_]/, '')
    end

    def validate_arguments
      raise Uploader::UploaderError, 'Filename must be provided' unless @filename.present?
      raise Uploader::UploaderError, 'File data must be provided' unless @data.present?
      content_type_valid?
    end

    def repeat_or_raise(err)
      if @retries <= UPLOAD_RETRIES
        log_retry_error
        sleep @retries
        @retries += 1
        upload
      else
        log_request_error(err)
        raise Uploader::UploaderError, err
      end
    end

    def log_infected_file
      Rails.logger.tagged('add_file') { Rails.logger.warn("Uploader::InfectedFileError: #{@filename}") }
    end

    def log_retry_error
      Rails.logger.tagged('add_file') {
        Rails.logger.warn('Uploader::RequestError::Retry': {retry_counter: @retries})
      }
    end

    def log_request_error(err)
      Rails.logger.tagged('add_file') {
        Rails.logger.warn('Uploader::RequestError': {error: err.inspect, backtrace: err.backtrace})
      }
    end
  end
end


