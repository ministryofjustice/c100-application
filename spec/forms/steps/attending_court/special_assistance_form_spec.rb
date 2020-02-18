require 'spec_helper'

RSpec.describe Steps::AttendingCourt::SpecialAssistanceForm do
  let(:arguments) { {
    c100_application: c100_application,
    hearing_loop: '1',
    braille_documents: '0',
    special_assistance_details: 'details',
  } }

  let(:c100_application) { instance_double(C100Application, court_arrangement: court_arrangement) }
  let(:court_arrangement) { CourtArrangement.new(special_assistance: ['hearing_loop'], special_assistance_details: 'details') }

  subject { described_class.new(arguments) }

  describe 'custom getters override' do
    it 'returns true if the attribute is in the list' do
      expect(subject.hearing_loop).to eq(true)
    end

    it 'returns false if the attribute is not in the list' do
      expect(subject.braille_documents).to eq(false)
    end
  end

  describe '#save' do
    context 'when no c100_application is associated with the form' do
      let(:c100_application) { nil }

      it 'raises an error' do
        expect { subject.save }.to raise_error(BaseForm::C100ApplicationNotFound)
      end
    end

    context 'when form is valid' do
      it 'saves the record' do
        expect(court_arrangement).to receive(:update).with(
          special_assistance: [:hearing_loop],
          special_assistance_details: 'details',
        ).and_return(true)

        expect(subject.save).to be(true)
      end
    end
  end
end
