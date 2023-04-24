# require 'rails_helper'

# RSpec.describe ApplicationIntent do
#   let(:value) { :foo }
#   subject     { described_class.new(value) }

#   describe '.values' do
#     it 'returns all possible values' do
#       expect(described_class.values.map(&:to_s)).to eq(%w(new continue))
#     end
#   end

#   describe '#new?' do
#     describe 'when the value is `new`' do
#       let(:value) { :new }

#       it 'returns true' do
#         expect(subject.new?).to eq(true)
#       end
#     end

#     describe 'when the value is `continue`' do
#       let(:value) { :continue }

#       it 'returns false' do
#         expect(subject.new?).to eq(false)
#       end
#     end
#   end

#   describe '#continue?' do
#     describe 'when the value is `new`' do
#       let(:value) { :new }

#       it 'returns false' do
#         expect(subject.continue?).to eq(false)
#       end
#     end

#     describe 'when the value is `continue`' do
#       let(:value) { :continue }

#       it 'returns true' do
#         expect(subject.continue?).to eq(true)
#       end
#     end
#   end
# end
