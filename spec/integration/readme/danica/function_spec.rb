# frozen_string_literal: true

require 'spec_helper'

describe Danica::Function do
  subject { described_class.build(:x, :y, :z) { z * (x**y) }.new(y: 3, z: Danica::PI) }

  describe '#to_tex' do
    it do
      expect(subject.to_tex).to eq('f(x, 3) = \pi \cdot x^{3}')
    end
  end

  describe '#to_gnu' do
    it do
      expect(subject.to_gnu).to eq('f(x) = pi * x**(3)')
    end
  end
end
