class DownloadToken < ApplicationRecord
  belongs_to :c100_application

  before_create :add_token

  def add_token
    chars = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
    self.token ||= (0...100).map { chars[rand(chars.length)] }.join
  end

  def url
    Aws::S3::Object.new(
      ENV["AWS_BUCKET"],
      key
    ).presigned_url(:get, expires_in: 3600)
  end
end
