module Summary
  class C8Form < BasePdfForm
    attr_reader :party_section

    def initialize(c100_application, party_section:)
      super(c100_application)
      @party_section = party_section
    end

    def name
      'C8'
    end

    def sections
      [
        Sections::FormHeader.new(c100_application, name: :c8_form),
        Sections::C8CourtDetails.new(c100_application),
        Partial.new(:c8_instructions),
        party_section
      ].flatten.select(&:show?)
    end
  end
end
