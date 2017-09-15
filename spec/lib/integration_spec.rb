require 'spec_helper'

describe 'integration' do
  describe 'a product of number and sum' do
    subject do
      Danica::Product.new(
        3, Danica::Sum.new(2, 4)
      )
    end

    describe '#to_tex' do
      it 'returns the correct tex string' do
        expect(subject.to_tex).to eq('3 \cdot \left(2 + 4\right)')
      end
    end

    describe '#to_gnu' do
      it 'returns the correct tex string' do
        expect(subject.to_gnu).to eq('3 * (2 + 4)')
      end
    end
  end

  describe 'a sum with negative numbers' do
    subject do
      Danica::Sum.new(Danica::Negative.new(1), 2, Danica::Negative.new(3), 4)
    end

    describe '#to_tex' do
      it 'returns the correct tex string' do
        expect(subject.to_tex).to eq('-1 + 2 -3 + 4')
      end
    end

    describe '#to_gnu' do
      it 'returns the correct tex string' do
        expect(subject.to_gnu).to eq('-1 + 2 -3 + 4')
      end
    end
  end
end
