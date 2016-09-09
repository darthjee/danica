require 'spec_helper'

describe Danica::Function do
  class Danica::Function
    class Spatial < Danica::Function
      variables :time, :acceleration, :initial_space, :initial_velocity
      delegate :to_tex, :to_gnu, to: :sum

      private

      def sum
        @sum ||= Sum.new(variables: parcels)
      end

      def parcels
        [
          initial_space,
          spatial_velocity,
          spatial_acceleration
        ]
      end

      def spatial_velocity
        Product.new(variables: [ initial_velocity, time ])
      end

      def spatial_acceleration
        Division.new(numerator: Product.new(variables: [ acceleration, time_squared ]), denominator: 2)
      end

      def time_squared
        Power.new(base: time, exponent: 2)
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
    context 'when creating the spatial function for constantly accelerated movement' do
      let(:expected) { 'S_0 + V_0 \cdot t + \frac{a \cdot t^{2}}{2}'  }

      it 'return the latex format CAM' do
        expect(subject.to_tex).to eq(expected)
      end
    end
  end

  describe '#to_gnu' do
    context 'when creating the spatial function for constantly accelerated movement' do
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
    end
  end
end
