require 'rails_helper'

RSpec.describe DownloadToken, type: :model do

  let(:c100_application) { C100Application.create }

  it 'adds a token after creation' do
    c100_application.download_tokens.create(key: '123')
    download_token = c100_application.download_tokens.first
    expect(download_token.token).not_to be_empty
  end

end
