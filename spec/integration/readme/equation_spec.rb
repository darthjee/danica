# frozen_string_literal: true

require 'spec_helper'

describe Danica::Equation do
  subject do
    described_class.build(:x, :y, :z) do
      left { x**2 + y**2 }
      right { number(1) - z**2 }
    end.new
  end

  describe '#to_gnu' do
    it 'generates the gnu format' do
      expect(subject.to_gnu).to eq('x**(2) + y**(2) = 1 -z**(2)')
    end
  end
end
