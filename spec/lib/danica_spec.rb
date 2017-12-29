require 'spec_helper'

describe Danica do
  describe '.build' do
    let(:result) { described_class.build(&block) }

    context 'when creating a addition' do
      let(:block) do
        proc { addition(1, 2) }
      end

      it 'returns the expected addition' do
        expect(result.expression_block).to eq(Danica::Operator::Addition.new(1,2))
      end
    end

    context 'when creating a power of addition and multiplication' do
      let(:block) do
        proc { power(addition(1, 2), multiplication(2,3)) }
      end
      let(:expected) do
        Danica::Operator::Power.new(
          Danica::Operator::Addition.new(1, 2),
          Danica::Operator::Multiplication.new(2, 3)
        )
      end

      it 'returns the expected power' do
        expect(result.expression_block).to eq(expected)
      end
    end

    context 'when starting with a negative object' do
      let(:block) do
        proc { - Danica::Wrapper::Number.new(10) }
      end
      let(:expected) { Danica::Wrapper::Negative.new(10) }

      it 'returns the expected negative' do
        expect(result.expression_block).to eq(expected)
      end
    end

    context 'when defining a function' do
      let(:block) do
        proc do
          function(:x) do
            power(x, 2)
          end
        end
      end
      let(:function) do
        Danica::LegacyFunction.build(:x) do
          Danica::Operator::Power.new(x, 2)
        end.new
      end

      it do
        expect(result).to be_a(Danica::LegacyFunction)
      end

      it 'returns the expected function with variables' do
        expect(result.variables_hash).to eq(function.variables_hash)
      end

      it 'returns the expected function with block' do
        expect(result.to_tex).to eq(function.to_tex)
      end
    end

    context 'when defining a negative output' do
      let(:block) do
        proc { -(sum(2, 3)) }
      end

      let(:expected) do
        Danica::Wrapper::Negative.new(
          Danica::Operator::Addition.new(2, 3)
        )
      end

      it 'wrap object with negative' do
        expect(result.expression_block).to eq(expected)
      end

      context 'for a number' do
        let(:block) do
          proc { -num(2) }
        end

        let(:expected) do
          Danica::Wrapper::Negative.new(2)
        end

        it 'wrap object with negative' do
          expect(result.expression_block).to eq(expected)
        end
      end
    end
  end
end

