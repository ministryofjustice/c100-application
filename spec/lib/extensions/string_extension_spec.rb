require 'rails_helper'

describe String do
  context 'when value is not a valid boolean' do
    it 'raises an error' do
      expect { 'x'.to_bool }.to raise_error(ArgumentError)
    end
  end

  context 'to_bool' do
    context 'for blank values' do
      it 'should be false for empty string' do
        expect(''.to_bool).to eq(false)
      end

      it 'should be false for only spaces string' do
        expect(' '.to_bool).to eq(false)
      end
    end

    context 'for truthy values' do
      %w(true t yes y 1).each do |value|
        it "should be true for '#{value}'" do
          expect(value.to_bool).to eq(true)
        end
      end
    end

    context 'for falsey values' do
      %W(false f no n 0).each do |value|
        it "should be false for '#{value}'" do
          expect(value.to_bool).to eq(false)
        end
      end
    end
  end
end
