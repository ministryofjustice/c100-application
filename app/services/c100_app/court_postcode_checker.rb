require 'c100_app/courtfinder_api'

module C100App
  class CourtPostcodeChecker
    AREA_OF_LAW = "Children".freeze

    def court_for(postcode)
      possible_courts = CourtfinderAPI.new.court_for(AREA_OF_LAW, postcode)
      candidate_court = choose_from(possible_courts)

      Court.create_or_refresh(candidate_court) if candidate_court
    end

    def court_slugs_blocklist
      Rails.configuration.court_slugs.fetch('blocklist')
    end

    private

    def choose_from(possible_courts)
      slug = nil
      first_with_slug = possible_courts.find do |court|
        slug = court[:slug] || court['slug']
      end
      first_with_slug unless court_slugs_blocklist.include?(slug)
    end
  end
end
