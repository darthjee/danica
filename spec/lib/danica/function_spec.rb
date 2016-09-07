require 'spec_helper'

describe Danica::Function do
  class Danica::Function
    class Spatial < Danica::Function
      attr_accessor :time, :acceleration, :initial_space, :initial_velocity
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
end
