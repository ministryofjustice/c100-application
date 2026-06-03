require 'spec_helper'

module Summary
  describe C8Form do
    let(:c100_application) { instance_double(C100Application) }
    let(:party_section) { instance_double('PartySection', show?: true) }

    subject { described_class.new(c100_application, party_section: party_section) }

    describe '#name' do
      it { expect(subject.name).to eq('C8') }
    end

    describe '#template' do
      it { expect(subject.template).to eq('steps/completion/summary/show.pdf') }
    end

    describe '#raw_file_path' do
      it { expect(subject.raw_file_path).to be_nil }
    end

    describe '#sections' do
      let(:party_section) { instance_double('PartySection', show?: true) }

      subject { described_class.new(c100_application, party_section: party_section) }

      before do
        allow_any_instance_of(Summary::Sections::BaseSectionPresenter).to receive(:show?).and_return(true)
      end

      it 'has the right sections in order' do
        sections = subject.sections

        expect(sections[0]).to be_a(Sections::FormHeader)
        expect(sections[1]).to be_a(Sections::C8CourtDetails)
        expect(sections[2]).to be_a(Partial)
        expect(sections[3]).to eq(party_section)
      end
    end
  end
end
