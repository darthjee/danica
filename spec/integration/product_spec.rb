require 'spec_helper'

describe 'integration of product' do
  describe 'of number and addition' do
    subject do
      Danica::Operator::Product.new(
        3, Danica::Operator::Addition.new(2, 4)
      )
    end

    describe '#to_gnu' do
      it 'returns the correct string' do
        expect(subject.to_gnu).to eq('3 * (2 + 4)')
      end
    end

    describe '#to_gnu' do
      it 'returns the correct string' do
        expect(subject.to_tex).to eq('3 \cdot \left(2 + 4\right)')
      end
    end
  end

  describe 'of additions' do
    subject do
      Danica::Operator::Product.new(
        Danica::Operator::Addition.new(1,2),
        Danica::Operator::Addition.new(3,4)
      )
    end

    describe '#to_gnu' do
      it 'returns the correct string' do
        expect(subject.to_gnu).to eq('(1 + 2) * (3 + 4)')
      end
    end

    describe '#to_tex' do
      it 'returns the correct string' do
        expect(subject.to_tex).to eq('\left(1 + 2\right) \cdot \left(3 + 4\right)')
      end
    end
  end
end
