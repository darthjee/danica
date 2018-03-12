require 'spec_helper'

shared_examples 'a generically generated function' do
  it 'returns a function class' do
    expect(function.class.superclass).to eq(described_class)
  end

  it 'returns a class whose instance responds to the variables' do
    variables.each do |variable|
      expect(function).to respond_to(variable)
    end
  end

  it 'returns a function that uses the block to process to_tex' do
    expect(function.to_tex).to eq('f(x, y) = x^{y}')
  end

  it 'returns a function that uses the block to process to_gnu' do
    expect(function.to_gnu).to eq('f(x, y) = x**(y)')
  end

  it 'returns a function thtat knows how to calculate' do
    expect(function.calculate(x: 2, y: 3)).to eq(8)
  end
end

describe Danica::Function do
  subject { function }
  let(:function) { function_class.new }
  let(:variables) { %i(x y) }
  let(:function_class) do
    described_class.build(*variables) do
      Danica::Operator::Power.new(x, y)
    end
  end

  describe '.for' do
    let(:expression_class) { Danica::Expression::Gauss }
    let(:expression) { expression_class.new }
    subject do
      described_class.for(expression_class).new
    end

    it 'returns a function' do
      expect(subject).to be_a(described_class)
    end

    it 'behaves like a function' do
      expect do
        subject.to_tex
      end.not_to raise_error
    end

    it 'creates a funcion out of an expression' do
      expect(subject.to_tex).to eq("f(x, \\mu, \\sigma) = #{expression.to_tex}")
    end

    context 'when passing an operator' do
      let(:expression_class) { Danica::Operator::Cos }

      it do
        expect(subject.to_tex).to eq("f(value) = #{expression.to_tex}")
      end
    end
  end

  describe '.build' do
    let(:function) do
      function_class.new(name: :f)
    end

    it_behaves_like 'a generically generated function'

    context 'when no block is given' do
      let(:function_class) do
        described_class.build(*variables)
      end

      it 'returns a function class' do
        expect(function_class.superclass).to eq(described_class)
      end
    end

    context 'when creating a class using build' do
      let(:function_class) { Danica::Function::Parabole }

      it 'has the defined variables on class definition' do
        expect(function_class.variables_names).to eq([:x])
      end

      it 'has the defined variables' do
        expect(function.variables_hash).to eq(x: Danica::Wrapper::Variable.new(name: :x))
      end

      context 'when calling to_tex' do
        it 'build function from block' do
          expect(function.to_tex).to eq('f(x) = x^{2}')
        end
      end

      context 'when calling to_gnu' do
        it 'build function from block' do
          expect(function.to_gnu).to eq('f(x) = x**(2)')
        end
      end
    end

    context 'when using a class that inherits from another class' do
      let(:function_class) { Danica::Function::SaddleParabole }

      it 'has the defined variables on class definition' do
        expect(function_class.variables_names).to eq([:x, :y])
      end

      it 'has the defined variables' do
        expect(function.variables_hash).to eq(
          x: Danica::Wrapper::Variable.new(name: :x),
          y: Danica::Wrapper::Variable.new(name: :y)
        )
      end

      context 'when calling to_tex' do
        it 'build function from block' do
          expect(function.to_tex).to eq('f(x, y) = x^{2} -y^{2}')
        end
      end

      context 'when calling to_gnu' do
        it 'build function from block' do
          expect(function.to_gnu).to eq('f(x, y) = x**(2) -y**(2)')
        end
      end
    end
  end

  describe '.create' do
    let(:function) do
      described_class.create(*variables) do
        Danica::Operator::Power.new(x, y)
      end.tap do |f|
        f.name = :f
      end
    end
    it_behaves_like 'a generically generated function'
  end

  describe '#name' do
    let(:function) do
      function_class.new(name: :f)
    end

    it do
      expect(function.name.content).to be_a(Danica::Function::Name)
    end

    context 'when changing the function variables' do
      it 'changes the name variables' do
        expect do
          function.x = 2
        end.to change { function.name.variables.map(&:content) }
      end
    end
  end

  describe '#to_tex' do
    context 'when function has a name' do
      let(:function) do
        function_class.new(name: :f)
      end

      it 'returns the full function description' do
        expect(function.to_tex).to eq('f(x, y) = x^{y}')
      end

      context 'and one of the variables is changed' do
        it 'uses the new variable value' do
          expect do
            function.y = 2
          end.to change(function, :to_tex).to('f(x, 2) = x^{2}')
        end
      end
    end

    context 'when a variable is set as a constant' do
      let(:function) do
        function_class.new(name: :f, x: Danica::PI)
      end

      it 'ignores the constant in the definition' do
        expect(function.to_tex).to eq('f(y) = \pi^{y}')
      end

      context 'from a hash' do
        let(:function) do
          function_class.new(name: :f, x: { latex: '\pi', gnu: 'pi', value: 3.14 })
        end

        it 'ignores the constant in the definition' do
          expect(function.to_tex).to eq('f(y) = \pi^{y}')
        end
      end
    end

    context 'when a variable is a number' do
      let(:function) do
        function_class.new(name: :f, x: 2)
      end

      it 'sohws the variable as number' do
        expect(function.to_tex).to eq('f(2, y) = 2^{y}')
      end
    end

    context 'when a variable has value' do
      let(:function) do
        function_class.new(name: :f, x: 2)
      end

      it 'sohws the variable as number' do
        expect(function.to_tex).to eq('f(2, y) = 2^{y}')
      end
    end
  end

  describe '#to_gnu' do
    context 'when function has a name' do
      let(:function) do
        function_class.new(name: :f)
      end

      it 'returns the full function description' do
        expect(function.to_gnu).to eq('f(x, y) = x**(y)')
      end
    end

    context 'when a variable is set as a constant' do
      let(:function) do
        function_class.new(name: :f, x: Danica::PI)
      end

      it 'ignores the constant in the definition' do
        expect(function.to_gnu).to eq('f(y) = pi**(y)')
      end

      context 'from a hash' do
        let(:function) do
          function_class.new(name: :f, x: { latex: '\pi', gnu: 'pi', value: 3.14 })
        end

        it 'ignores the constant in the definition' do
          expect(function.to_gnu).to eq('f(y) = pi**(y)')
        end
      end
    end

    context 'when a variable has value' do
      let(:function) do
        function_class.new(name: :f, x: { name: :x, value: 2 })
      end

      it 'sohws the variable as number' do
        expect(function.to_gnu).to eq('f(2, y) = 2**(y)')
      end
    end

    context 'when a variable is a number' do
      let(:function) do
        function_class.new(name: :f, x: 2)
      end

      it 'sohws the variable as number' do
        expect(function.to_gnu).to eq('f(2, y) = 2**(y)')
      end
    end
  end
end
