require 'aws-sdk-core'

Aws.config.update(
  region: ENV.fetch('AWS_S3_REGION'),
  credentials: Aws::Credentials.new(
    ENV.fetch('AWS_S3_ACCESS_KEY_ID'),
    ENV.fetch('AWS_S3_SECRET_ACCESS_KEY')
  )
)
