class Uploader
  class GetFile < ApiClient
    attr_reader :collection_ref, :document_key

    def initialize(collection_ref:, document_key:)
      super
      @collection_ref = collection_ref
      @document_key = document_key
    end

    def call
      files = Uploader::ListFiles.new(
        collection_ref: @collection_ref,
        document_key: @document_key
      ).call
      return unless files.contents.length
      file = files.contents[0]
      return unless file
      Uploader::File.new(file.key)
    end
  end
end
