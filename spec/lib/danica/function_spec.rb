require 'spec_helper'

describe Danica::Function do
  module Danica
    class Function::Spatial < Function
      variables :time, :acceleration, :initial_space, :initial_velocity
      delegate :to_f, :to_tex, :to_gnu, to: :sum

      private

      def sum
        @sum ||= Operator::Sum.new(parcels)
      end

      def parcels
        [
          initial_space,
          spatial_velocity,
          spatial_acceleration
        ]
      end

      def spatial_velocity
        Operator::Product.new(initial_velocity, time)
      end

      def spatial_acceleration
        Operator::Division.new(Operator::Product.new(acceleration, time_squared), 2)
      end

      def time_squared
        Operator::Power.new(time, 2)
      end
    end
  end

  let(:variables) do
    {
      time: :t,
      acceleration: 'a',
      initial_space: { name: :S0, latex: 'S_0' },
      initial_velocity: { name: :V0, latex: 'V_0' }
    }
  end

  let(:subject) { described_class::Spatial.new(variables) }

  describe '#to_tex' do
    context 'when creating the spatial operator for constantly accelerated movement' do
      let(:expected) { 'S_0 + V_0 \cdot t + \frac{a \cdot t^{2}}{2}'  }

      it 'return the latex format CAM' do
        expect(subject.to_tex).to eq(expected)
      end
    end
  end

  describe '#to_gnu' do
    context 'when creating the spatial operator for constantly accelerated movement' do
      let(:expected) { 'S0 + V0 * t + a * t**2/2'  }

      it 'return the latex format CAM' do
        expect(subject.to_gnu).to eq(expected)
      end
    end
  end

  describe '#variables_hash' do
    let(:expected) do
      {
        time: Danica::Variable.new(name: :t),
        acceleration: Danica::Variable.new(name: 'a'),
        initial_space: Danica::Variable.new( name: :S0, latex: 'S_0' ),
        initial_velocity: Danica::Variable.new( name: :V0, latex: 'V_0' )
      }
    end

    context 'when variables are already wrapped with DanicaVariable' do
      let(:variables) { expected }
      it 'returns a hash with the variabels' do
        expect(subject.variables_hash).to eq(expected)
      end
    end

    context 'when variables have been defined with string name' do
      before do
        variables.change_keys!(&:to_s)
      end

      it 'returns a hash with the variabels' do
        expect(subject.variables_hash).to eq(expected)
      end
    end

    context 'when variables are not wrapped yet' do
      it 'returns a hash with the variabels' do
        expect(subject.variables_hash).to eq(expected)
      end
    end

    context 'when changing a variable' do
      before do
        subject.time = :x
        expected[:time] = Danica::Variable.new(name: :x)
      end

      it do
        expect(subject.variables_hash).to eq(expected)
      end
    end

    context 'when initializing with array' do
      context 'as hash' do
        let(:variables) { [ :t, 'a', {name: :S0, latex: 'S_0'}, { name: :V0, latex: 'V_0' } ] }
        let(:subject) { described_class::Spatial.new(variables) }

        it 'returns a hash with the variabels' do
          expect(subject.variables_hash).to eq(expected)
        end
      end
    end

    context 'when initializing with sequence' do
      context 'as hash' do
        let(:variables) { [ :t, 'a', {name: :S0, latex: 'S_0'}, { name: :V0, latex: 'V_0' } ] }
        let(:subject) { described_class::Spatial.new(*variables, {}) }

        it 'returns a hash with the variabels' do
          expect(subject.variables_hash).to eq(expected)
        end
      end
    end

    context 'when initializing with variables array' do
      context 'as hash' do
        let(:variables) { [ :t, 'a', {name: :S0, latex: 'S_0'}, { name: :V0, latex: 'V_0' } ] }
        let(:subject) { described_class::Spatial.new(variables: variables) }

        it 'returns a hash with the variabels' do
          expect(subject.variables_hash).to eq(expected)
        end
      end
    end
  end

  describe '#variables' do
    context 'when initialized with an array of variables' do
      let(:subject) { described_class::Spatial.new(variables: variables.values) }
      let(:expected) { variables.values.map { |v| subject.send(:wrap_value, v)} }
      it do
        expect(subject.variables.compact).to eq(expected)
      end
    end

    context 'when not initializing all variables' do
      let(:subject) { described_class::Spatial.new }
      let(:time) { Danica::Variable.new(name: :t) }

      context 'when initialized with an empty variable set' do
        it do
          expect(subject.variables.compact).to be_empty
        end
      end

      context 'when changing a variable' do
        before do
          subject.time = time
        end

        it 'returns the list of variables' do
          expect(subject.variables.compact).to eq([ time ])
        end
      end

      context 'when initializing with a variable set' do
        let(:names) { [ :t, :a, :s0, :v0 ] }
        let(:subject) { described_class::Spatial.new *names }

        it 'returns the variables given oin initialization' do
          expect(subject.variables.map(&:name)).to eq(names)
        end

        context 'when initializing variables with a hash out of order' do
          let(:variables) do
            {
              initial_velocity: :v0,
              initial_space: :s0,
              acceleration: :a,
              time: :t
            }
          end
          let(:subject) { described_class::Spatial.new variables }

          it 'returns the variables given on initialization' do
            expect(subject.variables.map(&:name)).to eq(names)
          end
        end
      end
    end
  end

  describe '#calculate' do
    context 'when all variables have value' do
      let(:time_value) { 2 }
      let(:time) { time_value }
      let(:acceleration) { 3 }
      let(:initial_space) { 1 }
      let(:initial_velocity) { 1 }
      let(:subject) { described_class::Spatial.new(time, acceleration, initial_space, initial_velocity) }
      let(:expected) { initial_space + initial_velocity * time_value + acceleration * (time_value ** 2) / 2.0 }

      it 'retuirns the calculated value' do
        expect(subject.calculate).to eq(expected)
      end

      context 'when not all variables have value' do
        let(:time) { :t }

        it do
          expect { subject.calculate }.to raise_error(Danica::Exception::NotDefined)
        end

        context 'but calling calculate with a value for the variables' do
          it 'calculate using the given value' do
            expect(subject.calculate(time_value)).to eq(expected)
          end

          it 'does not change the values of then valued variables' do
            expect do
              subject.calculate(time_value)
            end.not_to change(subject.time, :valued?)
          end
        end

        context 'when calling with a hash for the values' do
          it 'calculate using the given value' do
            expect(subject.calculate(time: time_value)).to eq(expected)
          end

          it 'does not change the values of then valued variables' do
            expect do
              subject.calculate(time: time_value)
            end.not_to change(subject.time, :valued?)
          end
        end
      end
    end
  end
end
