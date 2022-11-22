# What is Document?
# Uploader.list_files is good.
# .all_for_collection takes the collection_ref and document_key and returns an array
# of Documents

# Document has a file name, a full_name, a collection ref, a last modified
#

class Document
  attr_reader :collection_ref, :full_name, :name, :last_modified
  alias_attribute :title, :name

  def initialize(attrs)
    @collection_ref = attrs.fetch(:collection_ref)
    @full_name = attrs[:name] || attrs.fetch(:title)
    @name = @full_name.split('/').last
    @last_modified = attrs[:last_modified]
  end

  def self.all_for_collection(collection_ref)
    for_collection(collection_ref, document_key: nil).group_by { |f| f.full_name.split('/')[1].to_sym }.tap do |docs|
      Rails.logger.info(docs)
    end
  end

  def self.for_collection(collection_ref, document_key:)
    Uploader.list_files(
      collection_ref: collection_ref,
      document_key: document_key
    ).contents.map do |file|
      new(
        name: file.key,
        collection_ref: collection_ref,
        last_modified: DateTime.parse(file.last_modified.to_s)
      )
    end.sort
  end

  def generate_download_token(c100_application)
    c100_application.download_tokens.create(
      key: @full_name
    )
  end

  def encoded_name
    Base64.encode64(name)
  end

  def name_with_collection
    "#{collection_ref}/#{name}"
  end

  # We use the encoded file name in the route path for DELETE (or fallback POST)
  # i.e. document_path(doc) due to it possibly having characters like dots, etc.
  #
  def to_param
    encoded_name
  end

  def <=>(other)
    last_modified <=> other.last_modified
  end

  def ==(other)
    other.collection_ref == collection_ref && other.full_name == full_name
  end
end
