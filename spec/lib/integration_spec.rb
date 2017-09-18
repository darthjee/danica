require 'spec_helper'

describe 'integration' do
  describe '#to_gnu' do
    describe 'a sum' do
      describe 'with negative numbers' do
        subject do
          Danica::Sum.new(Danica::Negative.new(1), 2, Danica::Negative.new(3), 4)
        end

        it 'returns the correct string' do
          expect(subject.to_gnu).to eq('-1 + 2 -3 + 4')
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

        it 'returns the correct string' do
          expect(subject.to_gnu).to eq('3 * (2 + 4)')
        end
      end

      describe 'of sums' do
        subject do
          Danica::Product.new(
            Danica::Sum.new(1,2),
            Danica::Sum.new(3,4)
          )
        end

        it 'returns the correct string' do
          expect(subject.to_gnu).to eq('(1 + 2) * (3 + 4)')
        end
      end
    end
  end
end
