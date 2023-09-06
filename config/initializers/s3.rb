require 'aws-sdk-core'

if ENV["IS_DOCKER"].blank?
  Aws.config.update(
    region: ENV["AWS_S3_REGION"],
    credentials: Aws::AssumeRoleWebIdentityCredentials.new(
      role_arn: ENV["AWS_ROLE_ARN"],
      web_identity_token_file: ENV["AWS_WEB_IDENTITY_TOKEN_FILE"]
    )
  )
end
