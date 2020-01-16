require 'spec_helper'

module Summary
  describe Sections::StatementOfTruth do
    let(:c100_application) {
      instance_double(C100Application,
                      applicants: applicants,
                      declaration_signee: declaration_signee,
                      declaration_signee_capacity: declaration_signee_capacity,
      )
    }

    let(:applicants) { [instance_double(Applicant, full_name: 'John Doe')] }
    let(:declaration_signee) { nil }
    let(:declaration_signee_capacity) { nil }

    subject { described_class.new(c100_application) }

    let(:answers) { subject.answers }

    describe '#name' do
      it { expect(subject.name).to eq(:statement_of_truth) }
    end

    describe '#show_header?' do
      it { expect(subject.show_header?).to eq(false) }
    end

    describe '#answers' do
      it 'has the correct number of rows' do
        expect(answers.count).to eq(1)
      end

      it 'has the correct rows in the right order' do
        expect(answers[0]).to be_an_instance_of(Partial)
        expect(answers[0].name).to eq(:statement_of_truth)
      end

      context 'propagates to the Partial the signee name as an ivar' do
        context 'when there is a signee name' do
          let(:declaration_signee) { 'Mr XYZ' }

          it 'returns the signee name' do
            expect(applicants).not_to receive(:first)
            expect(answers[0].ivar).to include(signee_name: 'Mr XYZ')
          end
        end

        context 'when there is no signee name but there are applicant names' do
          it 'picks the first applicant name' do
            expect(applicants).to receive(:first).and_call_original
            expect(answers[0].ivar).to include(signee_name: 'John Doe')
          end
        end

        context 'when there is no signee name and no applicant names' do
          it 'defaults to a placeholder text' do
            expect(applicants).to receive(:first).and_return(nil)
            expect(answers[0].ivar).to include(signee_name: '<name not entered>')
          end
        end
      end

      context 'propagates to the Partial the signee capacity as an ivar' do
        context 'when there is a signee capacity' do
          let(:declaration_signee_capacity) { UserType::REPRESENTATIVE }

          it 'returns the signee capacity' do
            expect(answers[0].ivar).to include(signee_capacity: 'Applicant’s solicitor')
          end
        end

        context 'when there is no signee capacity' do
          it 'defaults to be an applicant' do
            expect(applicants).to receive(:first).and_return(nil)
            expect(answers[0].ivar).to include(signee_capacity: 'Applicant')
          end
        end
      end
    end
  end
end
