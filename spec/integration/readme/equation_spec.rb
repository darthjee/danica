require 'spec_helper'

describe Danica::LegacyEquation do
  subject do
    described_class.new.tap do |equation|
      equation.left = Danica.build(:x, :y) do
        x ** 2 + y ** 2
      end
      equation.right = Danica.build(:x, :z) do
        number(1) - z ** 2
      end
    end
  end

  describe '#to_gnu' do
    it 'generates the gnu format' do
      expect(subject.to_gnu).to eq('x**(2) + y**(2) = 1 -z**(2)')
    end
  end
end
