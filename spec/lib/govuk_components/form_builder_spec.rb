require 'rails_helper'

class TestHelper < ActionView::Base
end

RSpec.describe GovukComponents::FormBuilder do
  def strip_text(text)
    text = text.strip.split("\n").map(&:strip)
    text.delete_if { |line| line == '' }
    text.join
  end

  let(:c100_application) { C100Application.new }
  let(:helper) { TestHelper.new }

  # Note: This is just a very broad and `happy path` test.
  # It is also coupled to current i18n so, if the strings change,
  # then the HTML fixture will need to also be updated.
  #
  describe '#text_field' do
    let(:builder) { described_class.new form.to_sym, c100_application, helper, {} }

    let(:form) { 'steps_application_details_form' }
    let(:attribute) { :application_details }

    let(:options) do
      { input_options: { class: 'govuk-input--width-10' } }
    end

    let(:html_output) { builder.text_field attribute, options }

    context 'no errors' do
      let(:html_fixture) { file_fixture('govuk_components/text_field.html').read }

      it 'outputs the expected markup' do
        expect(
          strip_text(html_output)
        ).to eq(
          strip_text(html_fixture)
        )
      end
    end

    context 'with errors' do
      let(:html_fixture) { file_fixture('govuk_components/text_field_error.html').read }

      before do
        c100_application.errors.add(attribute, :blank)
      end

      it 'outputs the expected markup' do
        expect(
          strip_text(html_output)
        ).to eq(
          strip_text(html_fixture)
        )
      end
    end

    context 'page_heading set to true' do
      let(:html_fixture) { file_fixture('govuk_components/text_field_page_heading.html').read }

      let(:options) do
        { label_options: { page_heading: true, size: 'xl' } }
      end

      it 'outputs the expected markup' do
        expect(
          strip_text(html_output)
        ).to eq(
          strip_text(html_fixture)
        )
      end
    end

    # TODO: decouple from i18n once extracted to gem or similar
    context 'label with a virtual attribute' do
      let(:options) { super().merge(i18n_attribute: :foobar) }

      it 'outputs the expected markup' do
        expect(
          strip_text(html_output)
        ).to match(/<label class="govuk-label" for="steps_application_details_form_application_details">Virtual attribute used temporarily in tests, to be removed<\/label>/)
      end
    end
  end
end
