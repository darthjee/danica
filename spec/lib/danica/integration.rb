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
  end
end
