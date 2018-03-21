class FullUkPostcodeValidator < ActiveModel::EachValidator
  MAPIT_URI_ROOT = "https://mapit.mysociety.org/postcode/".freeze

  def parsed_postcode(postcode)
    UKPostcode.parse(postcode)
  end

  def validate_each(record, attribute, value)
    entries = value.to_s.split('\n').reject(&:blank?)
    entries.each do |entry|
      unless well_formed?(entry) && exists?(entry)
        record.errors[attribute].to_a << error_message
      end
    end
  end

  def error_message
    I18n.t(:invalid, scope: [:errors, :attributes, :children_postcodes])
  end

  def well_formed?(postcode)
    parsed_postcode(postcode).full_valid?
  end

  def exists?(postcode)
    response = Net::HTTP.get_response(mapit_uri(postcode))
    response.code.eql?("200")
  end

  def mapit_uri(postcode)
    URI.join(mapit_uri_root, CGI.escape(postcode))
  end

  def mapit_uri_root
    MAPIT_URI_ROOT
  end
end
