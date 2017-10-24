require 'spec_helper'

shared_examples 'a generically generated expression' do
  it 'returns a expression class' do
    expect(expression.class.superclass).to eq(described_class)
  end

  it 'returns a class whose instance responds to the variables' do
    variables.each do |variable|
      expect(expression).to respond_to(variable)
    end
  end

  it 'returns a expression that uses the block to process to_tex' do
    expect(expression.to_tex).to eq('x^{y}')
  end

  it 'returns a expression that uses the block to process to_gnu' do
    expect(expression.to_gnu).to eq('x**(y)')
  end

  it 'returns a expression thtat knows how to calculate' do
    expect(expression.calculate(x: 2, y: 3)).to eq(8)
  end
end

describe Danica::Expression do
  let(:variables) { %i(x y) }
  let(:expression_class) do
    described_class.build(*variables) do
      Danica::Operator::Power.new(x, y)
    end
  end

  describe '.build' do
    let(:expression) do
      expression_class.new
    end

    it_behaves_like 'a generically generated expression'

    context 'when no block is given' do
      let(:expression_class) do
        described_class.build(*variables)
      end

      it 'returns a expression class' do
        expect(expression_class.superclass).to eq(described_class)
      end
    end

    context 'when creating a class using build' do
      let(:expression_class) { Danica::Hyperbole }

      it 'has the defined variables on class definition' do
        expect(expression_class.variables_names).to eq([:x])
      end

      it 'has the defined variables' do
        expect(expression.variables_hash).to eq(x: Danica::Wrapper::Variable.new(name: :x))
      end

      context 'when calling to_tex' do
        it 'build expression from block' do
          expect(expression.to_tex).to eq('x^{2}')
        end
      end

      context 'when calling to_gnu' do
        it 'build expression from block' do
          expect(expression.to_gnu).to eq('x**(2)')
        end
      end
    end

    context 'when using a class that inherits from another class' do
      let(:expression_class) { Danica::SaddleHyperbole }

      it 'has the defined variables on class definition' do
        expect(expression_class.variables_names).to eq([:x, :y])
      end

      it 'has the defined variables' do
        expect(expression.variables_hash).to eq(
          x: Danica::Wrapper::Variable.new(name: :x),
          y: Danica::Wrapper::Variable.new(name: :y)
        )
      end

      context 'when calling to_tex' do
        it 'build expression from block' do
          expect(expression.to_tex).to eq('x^{2} -y^{2}')
        end
      end

      context 'when calling to_gnu' do
        it 'build expression from block' do
          expect(expression.to_gnu).to eq('x**(2) -y**(2)')
        end
      end
    end
  end

  describe '.create' do
    let(:expression) do
      described_class.create(*variables) do
        Danica::Operator::Power.new(x, y)
      end
    end
    it_behaves_like 'a generically generated expression'
  end
end
