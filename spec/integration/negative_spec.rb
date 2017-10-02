require 'spec_helper'

describe 'integration of negative' do
  describe 'with a sum' do
    subject do
      Danica::Negative.new(
        Danica::Sum.new(1,2,3)
      )
    end

    describe '#to_gnu' do
      it 'returns the correct string' do
        expect(subject.to_gnu).to eq('-(1 + 2 + 3)')
      end
    end

    describe '#to_tex' do
      it 'returns the correct string' do
        expect(subject.to_tex).to eq('-\left(1 + 2 + 3\right)')
      end
    end
  end
end

