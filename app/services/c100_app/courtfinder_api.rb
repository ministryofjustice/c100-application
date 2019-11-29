require 'json'
require 'open-uri'

module C100App
  class CourtfinderAPI
    attr_accessor :logger

    # Very basic cache (almost like memoization) to save a few API requests.
    # This is just an in-memory cache and thus, suboptimal as we have more than one
    # instance of the application, but it could be replaced with RedisCacheStore.
    #
    SLUGS_CACHE ||= ActiveSupport::Cache::MemoryStore.new(namespace: 'court_slugs')
    SLUGS_CACHE_EXPIRE_IN = 72.hours.freeze

    API_ROOT              ||= "https://courttribunalfinder.service.gov.uk/".freeze
    API_URL               ||= "#{API_ROOT}%<endpoint>s.json?aol=%<aol>s&postcode=%<pcd>s".freeze
    COURTFINDER_ERROR_MSG ||= 'Exception hitting Courtfinder:'.freeze

    def initialize(params = {})
      self.logger = params[:logger] || Rails.logger
    end

    def court_for(area_of_law, postcode)
      JSON.parse(search(area_of_law, postcode))
    rescue StandardError => e
      handle_error(e)
    end

    def search(area_of_law, postcode)
      safe_postcode = postcode.gsub(/[^a-z0-9]/i, '')
      url = construct_url('search/results', area_of_law, safe_postcode)
      open(url).read
    end

    def court_url(slug, format: nil)
      slug_with_extension = [slug, format].compact.join('.')
      URI.join(API_ROOT, '/courts/', slug_with_extension).to_s
    end

    def court_lookup(slug)
      cache.fetch(slug, skip_nil: true, expires_in: SLUGS_CACHE_EXPIRE_IN) do
        JSON.parse(open(court_url(slug, format: :json)).read)
      end
    end

    def is_ok?
      status.eql? '200'
    end

    def cache
      SLUGS_CACHE
    end

    private

    def status
      request = Net::HTTP::Get.new('/healthcheck.json')
      http_object.request(request).code
    end

    def http_object
      uri = api_root_uri
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (http.port == 443)
      http
    end

    def api_root_uri
      URI.parse(API_ROOT)
    end

    def construct_url(endpoint, area_of_law, postcode)
      format(API_URL, endpoint: endpoint, aol: area_of_law, pcd: postcode)
    end

    # TODO: what's our plan for exception handling?
    # For now, just log it and re-raise - the caller should know what to do
    # better than we can (Dev principle!)
    def handle_error(e)
      log_error(COURTFINDER_ERROR_MSG, e)
      raise
    end

    def log_error(msg, exception)
      logger.info(msg)
      logger.info({caller: self.class.name, method: 'court_for', error: exception}.to_json)
      Raven.capture_exception(exception)
    end
  end
end
