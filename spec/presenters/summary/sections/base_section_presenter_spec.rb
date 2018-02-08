require 'spec_helper'

module Summary
  describe Sections::BaseSectionPresenter do
    let(:c100_application) { instance_double(C100Application) }
    subject { described_class.new(c100_application) }

    describe '#to_partial_path' do
      it 'returns the partial path' do
        expect(subject.to_partial_path).to eq('steps/completion/shared/section')
      end
    end

    describe '#name' do
      subject {described_class.new(c100_application, name: :anything)}

      it 'can be given a dynamic name' do
        expect(subject.name).to eq(:anything)
      end
    end

    describe '#show?' do
      context 'for an empty answers collection' do
        before do
          expect(subject).to receive(:answers).and_return([])
        end

        it 'returns false' do
          expect(subject.show?).to eq(false)
        end
      end

      context 'for a not empty answers collection' do
        before do
          expect(subject).to receive(:answers).and_return(['blah'])
        end

        it 'returns true' do
          expect(subject.show?).to eq(true)
        end
      end
    end

    describe '#show_header?' do
      it 'is true by default' do
        expect(subject.show_header?).to eq(true)
      end
    end

    describe '#t' do
      subject { described_class.new(c100_application, name: :my_presenter) }

      context 'for a default scope' do
        it 'builds the scope from the name of the presenter' do
          expect(I18n).to receive(:translate!).with('a_key', {scope: 'check_answers.my_presenter'})
          subject.send(:t, 'a_key')
        end
      end

      context 'for a custom scope' do
        it 'uses the custom scope' do
          expect(I18n).to receive(:translate!).with('a_key', {scope: 'test'})
          subject.send(:t, 'a_key', scope: 'test')
        end
      end
    end
  end
end
