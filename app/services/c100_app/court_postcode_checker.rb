module C100App
  class CourtPostcodeChecker
    AREA_OF_LAW = "childcare-arrangements".freeze

    def court_for(postcode)
      return nil if scotland_or_ni(postcode)

      possible_courts = CourtfinderAPI.new.court_for(AREA_OF_LAW, postcode)
      return nil unless possible_courts.has_key?('courts') || possible_courts.blank?

      candidate_court = court_lookup(possible_courts['courts'])

      return nil if closed_court(candidate_court)
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

    def court_lookup(courts)
      court = choose_from(courts)
      return unless court
      C100App::CourtfinderAPI.new.court_lookup(court['slug'])
    end

    def scotland_or_ni(postcode)
      postcode == 'TD1' || # weird exception to regex
        (/^(ZE|KW|IV|HS|PH|AB|DD|PA|FK|G[0-9]|KY|KA|DG|TD[^1]|TD1[^52]|EH|ML|BT)/i
                .match? postcode)
    end

    def closed_court(candidate_court)
      return if candidate_court.blank?
      candidate_court['open'] != true
    end
  end
end
