require 'spec_helper'

describe Summary::PdfPresenter do
  let(:c100_application) { C100Application.new(domestic_abuse: domestic_abuse) }
  let!(:applicant) { Applicant.new(c100_application: c100_application,
    are_contact_details_private: are_contact_details_private) }
  let(:generator) { double('Generator') }

  let(:are_contact_details_private) { 'no' }
  let(:domestic_abuse) { 'no' }

  subject { described_class.new(c100_application, generator) }

  describe '#generate' do
    before do
      allow(generator).to receive(:has_forms_data?).and_return(true)
    end

    it 'generates the C100 form' do
      expect(generator).to receive(:generate).with(
        an_instance_of(Summary::C100Form), copies: 1
      )

      subject.generate
    end

    context 'when C1A is triggered' do
      let(:domestic_abuse) { 'yes' }

      it 'generates the C100 form and the C1A' do
        expect(generator).to receive(:generate).with(
          an_instance_of(Summary::C100Form), copies: 1
        )

        expect(generator).to receive(:generate).with(
          an_instance_of(Summary::BlankPage), copies: 1
        )

        expect(generator).to receive(:generate).with(
          an_instance_of(Summary::C1aForm), copies: 1
        )

        subject.generate
      end
    end

    context 'when C8 is triggered' do
      let(:are_contact_details_private) { 'yes' }
      before do
        Applicant.create(c100_application: c100_application,
          are_contact_details_private: are_contact_details_private)
      end

      after do
        c100_application.applicants.destroy_all
      end


      it 'generates the C100 form and the C8' do
        expect(generator).to receive(:generate).with(
          an_instance_of(Summary::C100Form), copies: 1
        )

        expect(generator).to receive(:generate).with(
          an_instance_of(Summary::BlankPage), copies: 1
        )

        expect(generator).to receive(:generate).with(
          an_instance_of(Summary::C8Form), copies: 1
        )

        subject.generate
      end
    end

    context 'customisation of the bundle' do
      let(:domestic_abuse) { 'yes' }
      let(:are_contact_details_private) { 'yes' }

      it 'generates the C100 and C1A forms, but not the C8 form' do
        expect(subject).to receive(:generate_c100_form)
        expect(subject).to receive(:generate_c1a_form)
        expect(subject).not_to receive(:generate_c8_form)

        subject.generate(:c100, :c1a)
      end

      context 'blank pages' do
        before do
          expect(generator).to receive(:has_forms_data?).and_return(false)
          Applicant.create(c100_application: c100_application,
            are_contact_details_private: are_contact_details_private)
        end

        after do
          c100_application.applicants.destroy_all
        end

        it 'does not add unnecessary blank pages when generating individual forms' do
          expect(generator).to receive(:generate).with(
            an_instance_of(Summary::C8Form), copies: 1
          )

          expect(generator).not_to receive(:generate).with(
            an_instance_of(Summary::BlankPage), copies: 1
          )

          subject.generate(:c8)
        end
      end
    end
  end

  describe '#to_pdf' do
    it 'delegates method to the generator' do
      expect(generator).to receive(:to_pdf)
      subject.to_pdf
    end
  end

  describe '#has_forms_data?' do
    it 'delegates method to the generator' do
      expect(generator).to receive(:has_forms_data?)
      subject.has_forms_data?
    end
  end

  describe '#filename' do
    it { expect(subject.filename).to eq('C100 child arrangements application.pdf') }
  end
end
