require 'aws-sdk-core'

if Rails.env.production?
  Aws.config.update(
    region: ENV["AWS_S3_REGION"],
    credentials: Aws::AssumeRoleWebIdentityCredentials.new(
      role_arn: ENV["AWS_ROLE_ARN"],
      web_identity_token_file: ENV["AWS_WEB_IDENTITY_TOKEN_FILE"]
    )
  )
else
  Aws.config.update(
    region: ENV["AWS_S3_REGION"],
    credentials: Aws::Credentials.new(
      ENV["AWS_S3_ACCESS_KEY_ID"], 
      ENV["AWS_S3_SECRET_ACCESS_KEY"])
  )
end