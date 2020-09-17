module C100App
  class CourtfinderAPI
    API_BASE_URL = "https://courttribunalfinder.service.gov.uk".freeze
    SEARCH_PATH  = "/search/results.json?aol=%<aol>s&postcode=%<postcode>s".freeze
    COURT_PATH   = "/courts/%<slug>s.json".freeze
    HEALTH_CHECK = "/healthcheck.json".freeze

    HTTP_HEADERS = {
      'Accept' => 'application/json',
      'User-Agent' => 'child-arrangements-service',
    }.freeze

    # 60 seconds is the default that Net::HTTP uses internally,
    # but that is a very long time, so we reduce it.
    HTTP_OPTIONS = {
      open_timeout: 10,
      read_timeout: 20,
      use_ssl: true,
    }.freeze

    def self.court_url(slug)
      URI.join(API_BASE_URL, '/courts/', slug).to_s
    end

    def court_for(area_of_law, postcode)
      safe_postcode = postcode.gsub(/[^a-z0-9]/i, '')
      path = format(SEARCH_PATH, aol: area_of_law, postcode: safe_postcode)

      get_request(path)
    end

    def court_lookup(slug)
      path = format(COURT_PATH, slug: slug)

      get_request(path)
    end

    def is_ok?
      status
    end

    private

    def status
      get_request(HEALTH_CHECK).dig('*', 'status')
    rescue StandardError
      false
    end

    def get_request(path)
      request = Net::HTTP::Get.new(path, HTTP_HEADERS)
      uri = URI.parse(API_BASE_URL)

      Net::HTTP.start(uri.host, uri.port, :ENV, HTTP_OPTIONS) do |http|
        JSON.parse http.request(request).body
      end
    rescue StandardError => ex
      log_and_raise(ex)
    end

    def log_and_raise(exception)
      Raven.capture_exception(exception)
      raise
    end
  end
end
