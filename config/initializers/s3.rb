require 'aws-sdk-core'

Aws.config.update(
  region: ENV["AWS_S3_REGION"],
  credentials: Aws::Credentials.new(
    ENV["AWS_S3_ACCESS_KEY_ID"], 
    ENV["AWS_S3_SECRET_ACCESS_KEY"])
)
