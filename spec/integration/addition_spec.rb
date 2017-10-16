require 'spec_helper'

describe 'integration of addition' do
  describe 'with negative and positivenegative (+/-) numbers' do
    subject do
      Danica::Operator::Addition.new(
        Danica::Wrapper::Negative.new(1),
        2,
        -3,
        4,
        Danica::Wrapper::PlusMinus.new(5),
        Danica::Wrapper::Number.new(-6)
      )
    end

    describe '#to_gnu' do
      it 'returns the correct string' do
        expect(subject.to_gnu).to eq('-1 + 2 -3 + 4 + 5 -6')
      end
    end

    describe '#to_tex' do
      it 'returns the correct string' do
        expect(subject.to_tex).to eq('-1 + 2 -3 + 4 \pm 5 -6')
      end
    end
  end
end
