require 'spec_helper'

describe 'integration' do
  describe 'power' do
    describe 'of sums' do
      subject do
        Danica::Power.new(
          Danica::Sum.new(3, 4),
          Danica::Sum.new(5, 6)
        )
      end

      describe '#to_gnu' do
        it 'returns the correct string' do
          expect(subject.to_gnu).to eq('(3 + 4)**(5 + 6)')
        end
      end

      describe '#to_tex' do
        it 'returns the correct string' do
          expect(subject.to_tex).to eq('\left(3 + 4\right)^{5 + 6}')
        end
      end
    end
  end

  describe 'a sum' do
    describe 'with negative numbers' do
      subject do
        Danica::Sum.new(Danica::Negative.new(1), 2, Danica::Negative.new(3), 4)
      end

      describe '#to_gnu' do
        it 'returns the correct string' do
          expect(subject.to_gnu).to eq('-1 + 2 -3 + 4')
        end
      end

      describe '#to_tex' do
        it 'returns the correct string' do
          expect(subject.to_tex).to eq('-1 + 2 -3 + 4')
        end
      end
    end
  end

  describe 'a product' do
    describe 'of number and sum' do
      subject do
        Danica::Product.new(
          3, Danica::Sum.new(2, 4)
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

    describe 'of sums' do
      subject do
        Danica::Product.new(
          Danica::Sum.new(1,2),
          Danica::Sum.new(3,4)
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
end
