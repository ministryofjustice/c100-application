module CourtRedirections
  extend ActiveSupport::Concern

  def self.included(base)
    base.class_eval do
      after_save :redirect_urgent_hearings
    end
  end

  # https://tools.hmcts.net/jira/browse/RST-4834
  # Urgent hearings by West London Family Court
  # redirected to Barnet Civil and Family Courts
  def redirect_urgent_hearings
    return if urgent_hearing != 'yes' ||
              !court ||
              court.id != 'west-london-family-court'

    update(court: barnet_civil_and_family_courts_centre)
  end

  private

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
end
