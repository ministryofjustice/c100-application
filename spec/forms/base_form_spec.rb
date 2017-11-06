require 'spec_helper'

RSpec.describe BaseForm do
  describe '#persisted?' do
    it 'always returns false' do
      expect(subject.persisted?).to eq(false)
    end
  end

  describe '#new_record?' do
    it 'always returns true' do
      expect(subject.new_record?).to eq(true)
    end
  end

  describe '#to_key' do
    it 'always returns nil' do
      expect(subject.to_key).to be_nil
    end
  end

  describe '[]' do
    let(:c100_application) { instance_double(C100Application) }

    before do
      subject.c100_application = c100_application
    end

    it 'read the attribute directly without using the method' do
      expect(subject).not_to receive(:c100_application)
      expect(subject[:c100_application]).to eq(c100_application)
    end
  end

  describe '[]=' do
    let(:c100_application) { instance_double(C100Application) }

    it 'assigns the attribute directly without using the method' do
      expect(subject).not_to receive(:c100_application=)
      subject[:c100_application] = c100_application
      expect(subject.c100_application).to eq(c100_application)
    end
  end
end
