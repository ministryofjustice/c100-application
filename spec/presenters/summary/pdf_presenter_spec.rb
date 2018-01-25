require 'spec_helper'

module Summary
  describe PdfPresenter do
    let(:c100_application) { instance_double(C100Application) }
    subject { described_class.new(c100_application) }

    describe '#pdf_params' do
      it 'should have the expected parameters' do
        expect(subject.pdf_params).to eq({pdf: 'c100_application', footer: {right: '[page]'}})
      end
    end

    describe '#sections' do
      before do
        allow_any_instance_of(Summary::Sections::BaseSectionPresenter).to receive(:show?).and_return(true)
      end

      it 'has the right sections in the right order' do
        expect(subject.sections).to match_instances_array([
          Sections::HeaderSection,
          Sections::HelpWithFees,
          Sections::ApplicantRespondent,
          Sections::NatureOfApplication,
          Sections::RiskConcerns,
        ])
      end
    end
  end
end
