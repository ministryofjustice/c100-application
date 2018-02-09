require 'spec_helper'

describe Summary::Partial do
  let(:name) { 'anything' }

  subject { described_class.new(name) }

  describe '#to_partial_path' do
    it { expect(subject.to_partial_path).to eq('steps/completion/shared/anything') }
  end

  describe '#show?' do
    it { expect(subject.show?).to eq(true) }
  end
end
