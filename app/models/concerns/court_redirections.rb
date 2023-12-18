module CourtRedirections
  extend ActiveSupport::Concern

  REDIRECT_POSTCODES = %w[EN1 EN2 EN3 EN4 HA0 HA1 HA3 HA8 N10 N11 N12 N13 N14 N17 N18 N2 N20 N21 N22 N3 N9 NW11 NW4 NW7 NW9].freeze

  def self.included(base)
    base.class_eval do
      after_save :redirect_urgent_hearings
      after_save :revert_non_urgent_hearings
    end
  end

  # https://tools.hmcts.net/jira/browse/RST-4834
  # Urgent hearings by West London Family Court
  # redirected to Barnet Civil and Family Courts
  def redirect_urgent_hearings
    if urgent_hearing == 'yes' &&
       without_notice == 'yes' &&
       court &&
       court.id == 'west-london-family-court' &&
       redirect_postcode?(children_postcode)
      update(court: barnet_civil_and_family_courts_centre)
    end
  end

  def revert_non_urgent_hearings
    if (urgent_hearing == 'no' ||
       without_notice == 'no') &&
       court &&
       court.id == 'barnet-civil-and-family-courts-centre' &&
       redirect_postcode?(children_postcode)
      update(court: west_london_family_court)
    end
  end

  private

  # :nocov:
  # The tests to check these are excessive
  def west_london_family_court
    Court.find_or_create_by(id: 'west-london-family-court') do |court|
      court.name = "West London Family Court"
      court.gbs = "Y691"
      court.cci_code = nil
      court.address = {
        "town" => "Feltham",
        "type" => "Visit or contact us",
        "county" => "Greater London",
        "postcode" => "TW14 0LR",
        "description" => nil,
        "address_lines" => [
          "Gloucester House",
          "4 Dukes Green Avenue"
        ],
        "fields_of_law" => nil
      }
      court.email = "westlondonfamilyenquiries@justice.gov.uk"
    end
  end
  # :nocov:

  # :nocov:
  def barnet_civil_and_family_courts_centre
    Court.find_or_create_by(id: 'barnet-civil-and-family-courts-centre') do |court|
      court.name = "Barnet Civil and Family Courts Centre"
      court.gbs = "Y410"
      court.cci_code = 117
      court.address = {
        "town": "London",
        "type": "Visit or contact us",
        "county": "Greater London",
        "postcode": "N3 1BQ",
        "description": nil,
        "address_lines": [
          "St Marys Court",
          "Regents Park Road",
          "Finchley Central"
        ],
        "fields_of_law": nil
      }
      court.email = "C100applications@justice.gov.uk"
    end
  end
  # :nocov:
  def redirect_postcode?(postcode)
    # postcode needs to be uppercase for matching
    REDIRECT_POSTCODES.include?(postcode_area_code_regex(postcode.upcase).split(' ')[0].upcase)
  end

  def postcode_area_code_regex(postcode)
    # first capture group should capture the postcode area code e.g. N2
    matcher = /([A-Z]+[0-9]+)([A-Z ]*[0-9][A-Z]{2})/
    postcode.match(matcher)[1]
  end
end
