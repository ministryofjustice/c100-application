require 'rails_helper'

RSpec.describe GovukElementsErrorsHelper do
  def strip_text(text)
    text = text.strip.split("\n").map(&:strip)
    text.delete_if { |line| line == '' }
    text.join
  end

  # Note: This is just a very broad and `happy path` test.
  # It is also coupled to current i18n so, if the strings change,
  # then the HTML fixture will need to also be updated.
  #
  # TODO: decouple from app-specific models (`C100Application`)
  #
  describe '.error_summary' do
    subject { C100Application.new }

    context 'yes-no question' do
      let(:html_output) { GovukElementsErrorsHelper.error_summary(subject, 'There is an error') }
      let(:html_fixture) { file_fixture('govuk_components/error_summary.html').read }

      it 'outputs the expected markup' do
        subject.errors.add(:has_court_orders, :inclusion)

        expect(
          strip_text(html_output)
        ).to eq(
          strip_text(html_fixture)
        )
      end
    end

    context 'text box' do
      let(:html_output) { GovukElementsErrorsHelper.error_summary(form_object, 'There is an error') }
      let(:form_object) { Steps::Application::DetailsForm.build(subject) }

      it 'links to the expected text field' do
        form_object.errors.add(:application_details, :blank)

        expect(
          strip_text(html_output)
        ).to match(/<a href="#steps_application_details_form_application_details">/)
      end
    end
  end
end
