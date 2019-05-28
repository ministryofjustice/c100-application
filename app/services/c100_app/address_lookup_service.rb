module C100App
  class AddressLookupService
    ORDNANCE_SURVEY_URL = 'https://api.ordnancesurvey.co.uk/places/v1/addresses/postcode'.freeze

    attr_reader :postcode

    def initialize(postcode)
      @postcode = postcode
    end

    def result
      @result ||= MapAddressLookupResults.call(results)
    end

    def success?
      !failure?
    end

    def errors
      @errors ||= AddressLookupErrors.new
    end

    private

    def query_params
      {
        key: ENV.fetch('ORDNANCE_SURVEY_API_KEY'),
        postcode: postcode
      }
    end

    def results
      @results ||= perform_lookup
    end

    def failure?
      errors.any?
    end

    def perform_lookup
      uri = URI.parse(ORDNANCE_SURVEY_URL)
      uri.query = query_params.to_query
      response = Faraday.get(uri)

      if response.success?
        parse_successful_response(response.body)
      else
        errors.add(:lookup, :unsuccessful)
        []
      end
    rescue Faraday::ConnectionFailed => exception
      log_error(:service_unavailable, exception)
      []
    rescue JSON::ParserError, KeyError => exception
      log_error(:parser_error, exception)
      []
    end

    def parse_successful_response(response)
      parsed_body = JSON.parse(response)

      if parsed_body.fetch('header').fetch('totalresults').positive?
        parsed_body.fetch('results')
      else
        []
      end
    end

    def log_error(error, exception)
      errors.add(:lookup, error)
      return unless exception
      Raven.extra_context(postcode_lookup: error, postcode: postcode)
      Raven.capture_exception(exception)
    end
  end
end
