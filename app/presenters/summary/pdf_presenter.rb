module Summary
  class PdfPresenter
    DEFAULT_BUNDLE_FORMS ||= [:c100, :c1a, :c8].freeze

    attr_reader :c100_application
    attr_reader :pdf_generator
    attr_reader :collected_forms

    delegate :to_pdf, :pdf_data_rendered?, to: :pdf_generator

    def initialize(c100_application, generator = C100App::PdfGenerator.new)
      @c100_application = c100_application
      @pdf_generator = generator
    end

    # Gentle reminder this method does not return anything of value. Its purpose
    # is to generate one or more forms, which will be bundled together.
    # Once all the required forms have been generated, it is neccessary to call
    # the instance method `#to_pdf` to return the final, combined PDF.
    #
    def generate(*args, mode: :pdf)
      forms = args.presence || DEFAULT_BUNDLE_FORMS
      @collected_forms = [] if mode == :html

      generate_c100_form(mode) if forms.include?(:c100)
      generate_c1a_form(mode)  if forms.include?(:c1a)
      generate_c8_form(mode)   if forms.include?(:c8)
    end

    def filename
      'C100 child arrangements application.pdf'.freeze
    end

    def generate_applicant_c8s
      process_party_collection(
        c100_application.applicants,
        Sections::C8ApplicantsDetails,
        :pdf
      )
    end

    def generate_respondent_c8s
      process_party_collection(
        c100_application.respondents,
        Sections::C8RespondentsDetails,
        :pdf
      )
    end

    def generate_other_party_c8s
      process_party_collection(
        c100_application.other_parties,
        Sections::C8OtherPartiesDetails,
        :pdf
      )
    end

    private

    def generate_c100_form(mode = :pdf)
      process_form(Summary::C100Form.new(c100_application), mode)
    end

    def has_abuse_concerns_data?
      c100_application.has_safety_concerns? ||
        c100_application.abuse_concerns.any? { |abuse| abuse.answer.to_s.eql? 'yes' }
    end

    def generate_c1a_form(mode = :pdf)
      return unless has_abuse_concerns_data?

      add_blank_page_if_needed(mode)
      process_form(Summary::C1aForm.new(c100_application), mode)
    end

    def generate_c8_form(mode = :pdf)
      return unless c8_form_required?

      add_blank_page_if_needed(mode)

      process_all_parties(mode)
    end

    def c8_form_required?
      c100_application.confidentiality_enabled? || c100_application.other_confidentiality_enabled? ||
        c100_application.respondent_confidentiality_enabled?
    end

    def process_all_parties(mode)
      process_applicants(mode)
      process_respondents(mode)
      process_other_parties(mode)
    end

    def process_applicants(mode)
      process_party_collection(c100_application.applicants, Sections::C8ApplicantsDetails, mode)
    end

    def process_respondents(mode)
      process_party_collection(c100_application.respondents, Sections::C8RespondentsDetails, mode)
    end

    def process_other_parties(mode)
      process_party_collection(c100_application.other_parties, Sections::C8OtherPartiesDetails, mode)
    end

    def process_party_collection(collection, section_class, mode)
      collection.each_with_index do |party, index|
        section = build_section(section_class, party, index)

        next unless section.show?

        process_form(Summary::C8Form.new(c100_application, party_section: section, file_name: section.name), mode)
      end
    end

    def build_section(section_class, party, index)
      section_class.new(c100_application, party, index: index + 1)
    end

    # Avoid adding unnecessary blank pages if there are no preceding forms,
    # for example in the case we are generating individual forms like the C8.
    #

    def add_blank_page_if_needed(mode)
      if mode == :pdf
        return unless pdf_data_rendered?
      end

      process_form(Summary::BlankPage.new(c100_application), mode)
    end

    def process_form(form, mode)
      if mode == :pdf
        pdf_generator.generate(form, copies: 1)
      else
        @collected_forms << form
      end
    end
  end
end
