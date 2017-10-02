require 'spec_helper'

describe Danica do
  describe '.build' do
    let(:result) { described_class.build(&block) }

    context 'when creating a sum' do
      let(:block) do
        proc { sum(1, 2) }
      end

      it 'returns the expected sum' do
        expect(result).to eq(Danica::Sum.new(1,2))
      end
    end

    context 'when creating a power of sum and product' do
      let(:block) do
        proc { power(sum(1, 2), product(2,3)) }
      end
      let(:expected) do
        Danica::Power.new(
          Danica::Sum.new(1, 2),
          Danica::Product.new(2,3)
        )
      end

      it 'returns the expected power' do
        expect(result).to eq(expected)
      end
    end
  end
end

