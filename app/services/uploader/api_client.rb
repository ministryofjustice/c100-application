class Uploader
  class ApiClient
    def initialize(*_args)
      @client = Aws::S3::Client.new(
                    region: ENV["AWS_S3_REGION"],
                    credentials: Aws::AssumeRoleWebIdentityCredentials.new(
                      role_arn: ENV["AWS_ROLE_ARN"],
                      web_identity_token_file: ENV["AWS_WEB_IDENTITY_TOKEN_FILE"]
                    )
                  )
    end

    private

    def blob_name
      [@collection_ref, @document_key, @filename].compact.join('/')
    end
  end
end
