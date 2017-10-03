require 'spec_helper'

describe 'integration of sum' do
  describe 'with negative and positivenegative (+/-) numbers' do
    subject do
      Danica::Operator::Sum.new(
        Danica::Negative.new(1),
        2,
        Danica::Negative.new(3),
        4,
        Danica::PositiveNegative.new(5)
      )
    end

    describe '#to_gnu' do
      it 'returns the correct string' do
        expect(subject.to_gnu).to eq('-1 + 2 -3 + 4 + 5')
      end
    end

    describe '#to_tex' do
      it 'returns the correct string' do
        expect(subject.to_tex).to eq('-1 + 2 -3 + 4 \pm 5')
      end
    end
  end
end
