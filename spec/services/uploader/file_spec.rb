require 'spec_helper'

RSpec.describe Uploader::File do

  let(:filepath) { 'deb757fc-f06d-4233-b260-11edcb7416f3/consent_order_draft/letter.jpg' }

  it 'gets the name' do
    file = described_class.new(filepath)
    expect(file.name).to eq 'letter.jpg'
  end

  describe '.==' do
    it 'compares key values' do
      assert(Uploader::File.new('123') == Uploader::File.new('123'))
      assert(!(Uploader::File.new('123') == Uploader::File.new('456')))
    end
  end

  describe '.hash' do
    it 'hashes the key' do
      expect(Uploader::File.new('123').hash).to eq('123'.hash)
    end
  end

end