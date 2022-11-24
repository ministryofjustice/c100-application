class Uploader
  class ApiClient
    def initialize(*_args)
      @client = Aws::S3::Client.new(
        region: ENV.fetch('AWS_S3_REGION'),
        credentials: Aws::Credentials.new(
          ENV.fetch('AWS_S3_ACCESS_KEY_ID'),
          ENV.fetch('AWS_S3_SECRET_ACCESS_KEY')
        )
      )
    end

    private

    def blob_name
      [@collection_ref, @document_key, @filename].compact.join('/')
    end
  end
end
