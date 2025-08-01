# frozen_string_literal: true

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
  let(:variables) { %i[x y] }
  let(:expression_class) do
    described_class.build(*variables) do
      Danica::Operator::Power.new(x, y)
    end
  end

  describe '.build' do
    subject(:expression) do
      expression_class.new
    end

    it_behaves_like 'an object with basic operation'
    it_behaves_like 'an object that respond to basic_methods'
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
      let(:expression_class) { Danica::Parabole }

      it_behaves_like 'an object with basic operation'
      it_behaves_like 'an object that respond to basic_methods'
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
      let(:expression_class) { Danica::SaddleParabole }

      it_behaves_like 'an object with basic operation'
      it_behaves_like 'an object that respond to basic_methods'

      it 'has the defined variables on class definition' do
        expect(expression_class.variables_names).to eq(%i[x y])
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
    subject(:expression) do
      described_class.create(*variables) do
        Danica::Operator::Power.new(x, y)
      end
    end

    it_behaves_like 'an object with basic operation'
    it_behaves_like 'an object that respond to basic_methods'
    it_behaves_like 'a generically generated expression'
  end

  describe 'spatial' do
    subject(:expression) { described_class::Spatial.new(variables) }

    let(:variables) do
      {
        time: :t,
        acceleration: 'a',
        initial_space: { name: :S0, latex: 'S_0' },
        initial_velocity: { name: :V0, latex: 'V_0' }
      }
    end

    it_behaves_like 'an object with basic operation'
    it_behaves_like 'an object that respond to basic_methods'

    describe '#to_tex' do
      context 'when creating the spatial operator for constantly accelerated movement' do
        let(:expected) { 'S_0 + V_0 \cdot t + \frac{a \cdot t^{2}}{2}' }

        it 'return the latex format CAM' do
          expect(expression.to_tex).to eq(expected)
        end
      end
    end

    describe '#to_gnu' do
      context 'when creating the spatial operator for constantly accelerated movement' do
        let(:expected) { 'S0 + V0 * t + (a * t**(2))/(2)' }

        it 'return the latex format CAM' do
          expect(expression.to_gnu).to eq(expected)
        end
      end
    end

    describe '#variables_hash' do
      let(:expected) do
        {
          time: Danica::Wrapper::Variable.new(name: :t),
          acceleration: Danica::Wrapper::Variable.new(name: 'a'),
          initial_space: Danica::Wrapper::Variable.new(name: :S0, latex: 'S_0'),
          initial_velocity: Danica::Wrapper::Variable.new(name: :V0, latex: 'V_0')
        }
      end

      context 'when variables are already wrapped with Danica::Wrapper::Variable' do
        let(:variables) { expected }

        it 'returns a hash with the variabels' do
          expect(expression.variables_hash).to eq(expected)
        end
      end

      context 'when variables have been defined with string name' do
        before do
          variables.change_keys!(&:to_s)
        end

        it 'returns a hash with the variabels' do
          expect(expression.variables_hash).to eq(expected)
        end
      end

      context 'when variables are not wrapped yet' do
        it 'returns a hash with the variabels' do
          expect(expression.variables_hash).to eq(expected)
        end
      end

      context 'when changing a variable' do
        before do
          expression.time = :x
          expected[:time] = Danica::Wrapper::Variable.new(name: :x)
        end

        it do
          expect(expression.variables_hash).to eq(expected)
        end
      end

      context 'when initializing with array' do
        context 'when variables contain hashes' do
          subject(:expression) { described_class::Spatial.new(variables) }

          let(:variables) { [:t, 'a', { name: :S0, latex: 'S_0' }, { name: :V0, latex: 'V_0' }] }

          it 'returns a hash with the variabels' do
            expect(expression.variables_hash).to eq(expected)
          end
        end
      end

      context 'when initializing with sequence' do
        context 'when variables contain hashes' do
          subject(:expression) { described_class::Spatial.new(*variables, {}) }

          let(:variables) { [:t, 'a', { name: :S0, latex: 'S_0' }, { name: :V0, latex: 'V_0' }] }

          it 'returns a hash with the variabels' do
            expect(expression.variables_hash).to eq(expected)
          end
        end
      end

      context 'when initializing with variables hash' do
        context 'when variables contain hashes' do
          subject(:expression) { described_class::Spatial.new(variables: variables) }

          let(:variables) { [:t, 'a', { name: :S0, latex: 'S_0' }, { name: :V0, latex: 'V_0' }] }

          it 'returns a hash with the variabels' do
            expect(expression.variables_hash).to eq(expected)
          end
        end
      end
    end

    describe '#variables' do
      context 'when initialized with an array of variables' do
        subject(:expression) { described_class::Spatial.new(variables: variables.values) }

        let(:expected) { variables.values.map { |v| Danica::Wrapper::Variable.new(v.is_a?(Hash) ? v : { name: v }) } }

        it do
          expect(expression.variables.compact).to eq(expected)
        end
      end

      context 'when not initializing all variables' do
        subject(:expression) { described_class::Spatial.new }

        let(:time) { Danica::Wrapper::Variable.new(name: :t) }

        context 'when initialized with an empty variable set' do
          it do
            expect(expression.variables.compact).not_to be_empty
          end
        end

        context 'when changing a variable' do
          before do
            expression.time = time
          end

          let(:expected_variables) do
            [
              time,
              Danica::Wrapper::Variable.new(name: :acceleration),
              Danica::Wrapper::Variable.new(name: :initial_space),
              Danica::Wrapper::Variable.new(name: :initial_velocity)
            ]
          end

          it 'returns the list of variables merged default and new variables' do
            expect(expression.variables.compact).to eq(expected_variables)
          end
        end

        context 'when initializing with a variable set' do
          subject(:expression) { described_class::Spatial.new(*names) }

          let(:names) { %i[t a s0 v0] }

          it 'returns the variables given oin initialization' do
            expect(expression.variables.map(&:name)).to eq(names)
          end

          context 'when initializing variables with a hash out of order' do
            subject(:expression) { described_class::Spatial.new variables }

            let(:variables) do
              {
                initial_velocity: :v0,
                initial_space: :s0,
                acceleration: :a,
                time: :t
              }
            end

            it 'returns the variables given on initialization' do
              expect(expression.variables.map(&:name)).to eq(names)
            end
          end
        end
      end
    end

    describe '#calculate' do
      context 'when all variables have value' do
        subject(:expression) { described_class::Spatial.new(time, acceleration, initial_space, initial_velocity) }

        let(:time_value) { 2 }
        let(:time) { time_value }
        let(:acceleration) { 3 }
        let(:initial_space) { 1 }
        let(:initial_velocity) { 1 }

        let(:expected) { initial_space + (initial_velocity * time_value) + (acceleration * (time_value**2) / 2.0) }

        it 'retuirns the calculated value' do
          expect(expression.calculate).to eq(expected)
        end

        context 'when not all variables have value' do
          let(:time) { :t }

          it do
            expect { expression.calculate }.to raise_error(Danica::Exception::NotDefined)
          end

          context 'when calling calculate with a value for the variables' do
            it 'calculate using the given value' do
              expect(expression.calculate(time_value)).to eq(expected)
            end

            it 'does not change the values of then valued variables' do
              expect do
                expression.calculate(time_value)
              end.not_to change(expression.time, :valued?)
            end
          end

          context 'when calling with a hash for the values' do
            it 'calculate using the given value' do
              expect(expression.calculate(time: time_value)).to eq(expected)
            end

            it 'does not change the values of then valued variables' do
              expect do
                expression.calculate(time: time_value)
              end.not_to change(expression.time, :valued?)
            end
          end
        end
      end
    end
  end

  describe 'baskara' do
    context 'when using the default value for variables' do
      subject(:expression) { described_class::Baskara.new }

      it_behaves_like 'an object that respond to basic_methods'

      describe '#to_tex' do
        let(:expected) { '\frac{-b \pm \sqrt{b^{2} -4 \cdot a \cdot c}}{2 \cdot a}' }

        it 'return the latex format CAM' do
          expect(expression.to_tex).to eq(expected)
        end
      end

      describe '#to_gnu' do
        let(:expected) { '(-b + sqrt(b**(2) -4 * a * c))/(2 * a)' }

        it 'return the gnu format CAM' do
          expect(expression.to_gnu).to eq(expected)
        end
      end
    end
  end
end
