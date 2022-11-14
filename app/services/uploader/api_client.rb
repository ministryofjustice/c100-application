class Uploader
  class ApiClient
    def initialize(*_args)
      @client = Aws::S3::Client.new
    end

    private

    def blob_name
      [@collection_ref, @document_key, @filename].compact.join('/')
    end
  end
end
