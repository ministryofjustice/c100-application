class DocumentUpload
  include Virtus.model
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  attribute :tempfile, Object
  attribute :content_type, String
  attribute :original_filename, String
  attribute :collection_ref, String
  attribute :document_key, String

  attr_accessor :errors

  # TODO: decide on the final allowed max size and content types
  #
  MAX_FILE_SIZE = 20 # MB
  ALLOWED_CONTENT_TYPES = %w[
    application/pdf
    application/msword
    application/vnd.openxmlformats-officedocument.wordprocessingml.document
    image/jpeg
    image/pjpeg
    image/png
    image/tiff
    image/bmp
  ].freeze

  def initialize(obj, document_key: nil, content_type: nil, filename: nil, collection_ref: nil)
    raise ArgumentError, 'Must receive an IO object' unless obj.respond_to?(:read)

    self.tempfile = obj.respond_to?(:tempfile) ? obj.tempfile : obj
    self.content_type = content_type || obj.content_type
    self.original_filename = filename || obj.original_filename
    self.collection_ref = collection_ref
    self.document_key = document_key
    self.errors = ActiveModel::Errors.new(self)
  end

  def upload!(collection_ref: nil, document_key: nil)
    response = Uploader.add_file(
      collection_ref: collection_ref || self.collection_ref,
      document_key: document_key || self.document_key,
      filename: file_name,
      data: file_data
    )
    @_file_name = response.etag
  rescue Uploader::InfectedFileError
    add_error(:virus_detected)
  rescue Uploader::UploaderError => e
    # For generic upload errors (other than infected), we want to keep track of what happened
    Sentry.capture_exception(e)

    add_error(:response_error)
  end

  def file_name
    @_file_name ||= unique_filename(suffix: '(%d)')
  end

  def encoded_file_name
    Base64.encode64(file_name)
  end

  def file_size
    tempfile.size
  end

  def valid?
    validate
    errors.empty?
  end

  def errors?
    errors.any?
  end

  # Used by Rails responders when responding with JSON.
  def to_hash
    {name: file_name, encoded_name: encoded_file_name, collection_ref:}
  end

  private

  # We encode and decode the file data because this fixes
  # issues with UTF-8 encoding
  #
  def file_data
    Base64.decode64(Base64.encode64(tempfile.read))
  end

  # returns array of documents
  def uploaded_documents
    @_uploaded_documents ||= Document.for_collection(collection_ref, document_key:)
  end

  def unique_filename(suffix:)
    new_filename = original_filename
    found_copies = 0
    previous_suffix = ''

    while uploaded_documents.map(&:name_with_collection).include?("#{collection_ref}/#{new_filename}")
      current_suffix = suffix % (found_copies += 1)

      basename  = Pathname(new_filename).sub_ext('').to_s
      extension = File.extname(new_filename)

      # Given a basename `image`, extension `.jpg` and previous_suffix `''`, it returns:
      #   name: image
      #   _sep: ''
      #   new_filename: image(1).jpg
      #
      # Given a basename `image`, extension `.jpg` and previous_suffix `(1)`, it returns:
      #   name: image
      #   _sep: '(1)'
      #   new_filename: image(2).jpg
      #
      name, _sep = basename.rpartition(previous_suffix)
      new_filename = [name, current_suffix, extension].join

      previous_suffix = current_suffix
    end

    new_filename
  end

  def validate
    add_error(:invalid_characters) unless valid_characters?
    add_error(:file_size) if file_size > MAX_FILE_SIZE.megabytes
    add_error(:content_type) unless content_type.downcase.in?(ALLOWED_CONTENT_TYPES)
  end

  def add_error(code)
    errors.add(code, translate(code)) unless errors.key?(code)
  end

  def translate(key)
    I18n.translate("errors.#{key}", scope: 'document_upload', file_name: original_filename, max_size: MAX_FILE_SIZE)
  end

  def encoding_options
    {
      invalid: :replace, # Replace invalid byte sequences
      undef: :replace, # Replace anything not defined in ASCII
      replace: '*', # Use a blank for those replacements
      universal_newline: true # Always break lines with \n
    }
  end

  def valid_characters?
    return true if file_name.ascii_only?
    @_file_name = file_name.unicode_normalize(:nfkc)
    unless @_file_name.ascii_only?
      @_file_name = @_file_name.encode(Encoding.find('ASCII'), **encoding_options)
    end
    @_file_name.ascii_only?
  end
end
